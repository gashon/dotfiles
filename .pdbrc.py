try:
    import torch

    use_torch = True
except ImportError:
    import numpy as np

    use_torch = False

import hashlib


def hw(tensor):
    if use_torch:
        torch.save(tensor, "/tmp/hw")
    else:
        raise NotImplementedError("Only PyTorch tensors are supported")


def ref(tensor):
    if use_torch:
        torch.save(tensor, "/tmp/ref")
    else:
        raise NotImplementedError("Only PyTorch tensors are supported")


def compare(hw_path="/tmp/hw", ref_path="/tmp/ref"):
    if not use_torch:
        raise NotImplementedError("Only PyTorch tensors are supported")

    device = "cuda" if torch.cuda.is_available() else "cpu"

    hw = torch.load(f"{hw_path}", map_location="cpu").to(device)
    ref = torch.load(f"{ref_path}", map_location="cpu").to(device)

    print()
    print(f"{hw.device=}")
    print(f"{ref.device=}")
    print()

    print(f"{hw.dtype=}")
    print(f"{ref.dtype=}")
    print()

    print(f"{hw.shape=}")
    print(f"{ref.shape=}")
    print()

    abs_diff = torch.abs(hw - ref)
    max_diff = torch.max(abs_diff).item()
    median_diff = torch.median(abs_diff).item()

    # Calculate relative errors, avoiding division by zeroj
    with torch.no_grad():
        nonzero_mask = ref != 0
        relative_error = torch.zeros_like(ref)
        relative_error[nonzero_mask] = abs_diff[nonzero_mask] / torch.abs(
            ref[nonzero_mask]
        )
        median_relative_error = (
            torch.median(relative_error[nonzero_mask]).item()
            if torch.any(nonzero_mask)
            else float("inf")
        )
        mean_relative_error = (
            torch.mean(relative_error[nonzero_mask]).item()
            if torch.any(nonzero_mask)
            else float("inf")
        )
        print(f"{median_relative_error=}")
        print(f"{mean_relative_error=}")

    print(f"{max_diff=}")
    print(f"{median_diff=}")


def get_ref(ref_path="/tmp/ref"):
    if not use_torch:
        raise NotImplementedError("Only PyTorch tensors are supported")

    ref = torch.load(ref_path)

    return ref


def get_hw(hw_path="/tmp/hw"):
    if not use_torch:
        raise NotImplementedError("Only PyTorch tensors are supported")

    hw = torch.load(hw_path)

    return hw


def hw_in_ref():
    if not use_torch:
        raise NotImplementedError("Only PyTorch tensors are supported")

    hw = torch.load("/tmp/hw")
    ref = torch.load("/tmp/ref")

    def convert_to_tensor(x):
        if isinstance(x, torch.Tensor):
            return x
        elif isinstance(x, np.ndarray):
            return torch.from_numpy(x)
        elif isinstance(x, list):
            return torch.tensor(x)
        elif isinstance(x, torch.distributed.tensor.DTensor):
            return x.to_local()
        else:
            raise ValueError(f"Unsupported type: {type(x)}")

    hw = convert_to_tensor(hw)
    ref = convert_to_tensor(ref)

    hw_is_subset = torch.isin(hw, ref).all().item()

    print(f"{hw_is_subset=}")


def replicate(tensor):
    ndim = len(tensor.device_mesh.mesh_dim_names)
    return tensor.redistribute(
        placements=[torch.distributed.tensor.placement_types.Replicate()] * ndim
    )


def _hash(x):
    if use_torch:
        data = x.cpu().to(dtype=torch.float32).numpy()
    else:
        # Assume input is already a NumPy array
        data = x.astype(np.float32)

    print(hashlib.sha256(data.tobytes()).hexdigest())
