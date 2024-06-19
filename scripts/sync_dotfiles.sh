# sync_dotfiles.sh 
# sync dotfiles to git dir

if [ $(basename $(pwd)) != "dotfiles" ]; then
    echo "Please run this script in dotfiles directory"
    exit 1
fi

target_dir=$(pwd)
dirs=(.psqlrc .vimrc .config/kitty .config/nvim .zshrc )

for dir in ${dirs[@]}; do
   target_dir=$(dirname $dir)
   rsync -av --delete --progress $HOME/$dir $(pwd)/$target_dir
done

