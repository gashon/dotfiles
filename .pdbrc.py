try:
    import torch

    use_torch = True
except ImportError:
    import numpy as np

    use_torch = False

import hashlib


def compare_tensors(grad_hw, grad_ref):
    if use_torch:
        abs_diff = torch.abs(grad_hw - grad_ref)
        max_diff = torch.max(abs_diff).item()
        median_diff = torch.median(abs_diff).item()

        # Calculate relative errors, avoiding division by zero
        with torch.no_grad():
            nonzero_mask = grad_ref != 0
            relative_error = torch.zeros_like(grad_ref)
            relative_error[nonzero_mask] = abs_diff[nonzero_mask] / torch.abs(
                grad_ref[nonzero_mask]
            )
            median_relative_error = (
                torch.median(relative_error[nonzero_mask]).item()
                if torch.any(nonzero_mask)
                else float("inf")
            )
    else:
        abs_diff = np.abs(grad_hw - grad_ref)
        max_diff = np.max(abs_diff)
        median_diff = np.median(abs_diff)

        # Calculate relative errors, avoiding division by zero
        nonzero_mask = grad_ref != 0
        relative_error = np.zeros_like(grad_ref, dtype=float)
        relative_error[nonzero_mask] = abs_diff[nonzero_mask] / np.abs(
            grad_ref[nonzero_mask]
        )
        median_relative_error = (
            np.median(relative_error[nonzero_mask])
            if np.any(nonzero_mask)
            else float("inf")
        )

    return max_diff, median_diff, median_relative_error


def _hash(x):
    if use_torch:
        data = x.cpu().to(dtype=torch.float32).numpy()
    else:
        # Assume input is already a NumPy array
        data = x.astype(np.float32)

    print(hashlib.sha256(data.tobytes()).hexdigest())
