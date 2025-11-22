# Ladybird Builder GitHub Actions

This repository contains GitHub Actions workflows to automatically build and release Ladybird Browser for major Linux distributions.

## Overview

This is a **builder repository** that automatically:
- Clones the official Ladybird Browser source code from [LadybirdBrowser/ladybird](https://github.com/LadybirdBrowser/ladybird)
- Builds Ladybird Browser on Ubuntu and Fedora
- Creates releases with auto-incrementing version tags (starting from v1.0.0)
- Packages binaries as portable tarballs for easy distribution
- Runs twice daily to get the latest commits
- Supports manual triggering via workflow_dispatch
- Includes all required graphics and audio dependencies

## How It Works

1. **Clone Source**: The workflow clones the official Ladybird repository
2. **Install Dependencies**: Installs all required build dependencies for each distribution
3. **Build**: Uses Ladybird's official build script (`./Meta/ladybird.py build`)
4. **Package**: Creates portable tarballs containing the binary and resources
5. **Release**: Creates GitHub releases with auto-incrementing version tags and tarball packages

## Dependencies

The workflow automatically installs all required dependencies including:

- **Build Tools**: CMake, Ninja, NASM, autoconf, automake
- **Compilers**: GCC 14, Clang 20 with C++23 support
- **Graphics**: Mesa, OpenGL, X11 development libraries
- **Audio**: PulseAudio development libraries
- **Qt6**: Full Qt6 development environment
- **Fonts**: Liberation fonts for proper text rendering

## Workflow Features

### Build Matrix
- **Ubuntu**: Built with GCC 14 compiler
- **Fedora**: Latest Fedora container with system compiler

### Release Strategy
- Versioning starts at `v1.0.0` and auto-increments patch version
- Each successful build creates a new release with tag (e.g., v1.0.1, v1.0.2)
- Release includes tarball packages for all supported platforms

### Schedule
- Runs twice daily at 00:00 and 12:00 UTC
- Also triggers on pushes to main/master branches
- Manual triggering available via GitHub UI

## Usage

### Automatic Releases
The workflow automatically creates releases when:
1. Code is pushed to main/master branches
2. Scheduled runs complete successfully
3. Manually triggered via GitHub Actions UI

### Manual Trigger
To manually trigger a build:
1. Go to **Actions** tab in GitHub
2. Select **Build and Release Ladybird Browser**
3. Click **Run workflow**
4. Choose branch and click **Run workflow**

### Artifacts
Each release contains:
- `ladybird-ubuntu.tar.gz` - Ubuntu build with GCC 14
- `ladybird-fedora.tar.gz` - Fedora build

Each tarball includes:
- Ladybird binary
- Required libraries  
- All necessary resource files (automatically handled by CMake build system)
- Complete portable binary environment

## Installation

1. Download the appropriate tarball for your distribution from the Releases page
2. Extract the files:
   ```bash
   tar -xzf ladybird-ubuntu.tar.gz  # or ladybird-fedora.tar.gz
   ```
3. Run the Ladybird binary:
   ```bash
   ./Ladybird
   ```

**Note:** The tarballs are created directly from the build directory and include all necessary files for a complete portable installation.

## Requirements

The workflow installs all necessary dependencies automatically:
- Qt6 development packages
- C++23 capable compiler (GCC 14 / Clang 20)
- Build tools (CMake, Ninja, NASM, etc.)
- Audio support (PulseAudio)

## Versioning

The versioning follows semantic versioning:
- **Major**: Breaking changes (manual updates required)
- **Minor**: New features (auto-incremented)
- **Patch**: Bug fixes (auto-incremented)

Starting version: `v1.0.0`

## Repository Structure

```
ladybird-builder/
├── .github/
│   ├── workflows/
│   │   └── build-and-release.yml    # Main workflow file
│   └── workflow-config.json          # Configuration file
├── scripts/
│   ├── version-manager.sh           # Version management
│   └── test-workflow.sh             # Workflow testing
├── README.md                        # Main documentation
└── SETUP.md                         # Setup guide
```

## Contributing

To modify the workflow:
1. Edit `.github/workflows/build-and-release.yml`
2. Test changes in a fork or branch
3. Submit a pull request

## License

This project is licensed under the same license as Ladybird Browser.

## Related Projects

- [Ladybird Browser](https://github.com/LadybirdBrowser/ladybird) - The official Ladybird Browser repository
- [Ladybird Documentation](https://github.com/LadybirdBrowser/ladybird/blob/master/Documentation/BuildInstructionsLadybird.md) - Official build instructions