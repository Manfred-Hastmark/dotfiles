
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
  elif [ -d "$link_path" ]; then
    # If the target is a directory, ask if they want to remove it and replace it with a symlink
    read -p "A directory already exists at '$link_path'. Do you want to remove the directory and replace it with a symlink? (y/n): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
      rm -rf "$link_path"  # Remove the directory
      echo "Deleted the existing directory at '$link_path'."
    else
      echo "Keeping the existing directory. No changes made."
      return 0
    fi
  elif [ -e "$link_path" ]; then
    # If there's a regular file or something else at the symlink path, we ask for confirmation
    echo "A file or other type of object already exists at '$link_path'. Please remove it manually."
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
create_symlink "${dir}/nvim" "$HOME/.config/nvim"

# Clangd
create_symlink "${dir}/clangd" "$HOME/.config/clangd"

# i3
create_symlink "${dir}/i3" "$HOME/.config/i3"
create_symlink "${dir}/i3status" "$HOME/.config/i3status"

# Wezterm
create_symlink "${dir}/wezterm" "$HOME/.config/wezterm"

# Zsh
clone_repository "https://github.com/ohmyzsh/ohmyzsh" "$HOME/.oh-my-zsh"
create_symlink "${dir}/zsh/.zshrc" "$HOME/.zshrc"
create_symlink "${dir}/zsh/custom.zsh-theme" "$HOME/.oh-my-zsh/themes/custom.zsh-theme"
