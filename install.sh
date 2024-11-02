
#!/bin/bash

# Check for the "yes to all" flag
yes_to_all=false
if [[ "$1" == "-Y" ]]; then
  yes_to_all=true
fi

dir=$(pwd)

create_symlink() {
  local target_dir="$1"  # Source directory or file for the symlink
  local link_path="$2"   # Target path for the symlink

  # Check if the symlink already exists
  if [ -L "$link_path" ]; then
    if $yes_to_all; then
      # Automatically delete if the yes-to-all flag is set
      rm "$link_path"
      echo "Deleted the existing symlink at '$link_path'."
    else
      # Prompt the user for action
      read -p "The symlink '$link_path' already exists. Do you want to delete it and create a new one? (y/n): " choice
      
      if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        rm "$link_path"
        echo "Deleted the existing symlink."
      else
        echo "Keeping the existing symlink. No changes made."
        return 0
      fi
    fi
  elif [ -e "$link_path" ]; then
    echo "A file or directory (not a symlink) already exists at '$link_path'. Please remove it manually."
    return 1
  fi

  # Create the new symlink
  ln -s "$target_dir" "$link_path"
  echo "Created a new symlink at '$link_path'."
}

# Function to clone a Git repository with checks
clone_repository() {
  local repo_url="$1"     # URL of the Git repository
  local target_dir="$2"   # Target directory for cloning

  if [ -d "$target_dir" ]; then
    if $yes_to_all; then
      # Automatically delete if the yes-to-all flag is set
      rm -rf "$target_dir"  # Use -rf to remove the directory recursively
      echo "Deleted the existing directory at '$target_dir'."
    else
      read -p "The directory '$target_dir' already exists. Do you want to delete it and clone again? (y/n): " choice
      
      if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        rm -rf "$target_dir"
        echo "Deleted the existing directory."
      else
        echo "Keeping the existing directory. No changes made."
        return 0
      fi
    fi
  fi

  git clone "$repo_url" "$target_dir"
  echo "Cloned repository '$repo_url' into '$target_dir'."
}

# Tmux
clone_repository "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"
create_symlink "${dir}/tmux" "$HOME/.config/tmux"

# Neovim
create_symlink "${dir}/nvim" "$HOME/.config/nvim"
reate_symlink "${dir}/nvim" "$HOME/.config/nvim"
