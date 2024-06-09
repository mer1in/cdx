# cdx

cdx simplifies navigation in the terminal by providing shortcuts, project root detection, and directory bookmarking, enhancing productivity in command-line environments.

## Features

- **Project Root Detection**: Quickly navigate to the root directory of Git or SVN projects using the `cdr` command.
- **Directory Bookmarking**: Store and access frequently used directories using single-letter aliases.
- **Fuzzy Search**: Easily search and navigate through bookmarked directories with fuzzy search capability.
- **Temporary Folder Creation**: Create temporary folders and navigate into them with the `cdt` command.
- **Reserved Shortcuts Handling**: Handle reserved shortcuts like 'r' for git root and 't' for temporary folder.
- **Upgrade Support**: Seamless upgrade process with automatic detection of existing installations.

## Requirements

- cdx requires `fzf` (a command-line fuzzy finder) to be installed. You can find the installation instructions for `fzf` here: [fzf Installation](https://github.com/junegunn/fzf#installation).
- Bash version 5 or greater.

## Installation

To install cdx, simply run the following command in your terminal:

```bash
curl -sSL https://raw.githubusercontent.com/mer1in/cdx/main/installer.sh | bash
```

## Usage
After installation, restart your terminal session or run:
```bash
source ~/.bashrc
```

- **`cdr`**: Change directory to the root of the current project.
- **`sda`**: Store the current directory with a single-letter alias (replace 'a' with any letter).
- **`cda`**: Change directory to the directory associated with a single-letter alias (replace 'a' with the stored letter).
- **`cdt`**: Create a temporary folder and navigate into it.
- **`cdswd-widget`**: Fuzzy search and navigate through bookmarked directories.
## Key Bindings
- **`Ctrl+gd`**: Trigger the fuzzy search for stored directories.
- **`Ctrl+xr`**: Reload .bashrc and apply changes.
For more information and advanced usage, refer to the documentation within the script or run cdx_help after installation.

License
This project is licensed under the MIT License - see the LICENSE file for details.
