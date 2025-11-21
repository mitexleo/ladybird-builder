# Ladybird Builder GitHub Actions - Setup Guide

## Overview

This repository contains automated GitHub Actions workflows to build and release Ladybird Browser for major Linux distributions. The workflow automatically builds the browser, packages binaries, and creates releases with auto-incrementing version tags.

## Quick Setup

1. **Create a new GitHub repository** or use this existing one
2. **Push the code** to your GitHub repository
3. **Enable GitHub Actions** (enabled by default)
4. **Monitor the workflow** in the Actions tab

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
└── SETUP.md                         # This file
```

## Workflow Features

### Build Platforms
- **Ubuntu**: Latest Ubuntu with GCC 14 and Clang 20 compilers
- **Fedora**: Latest Fedora in Docker container

### Automation
- **Twice daily builds**: 00:00 and 12:00 UTC
- **Auto-versioning**: Starts at v1.0.0, increments patch version
- **Release creation**: Automatic GitHub releases with artifacts
- **Manual triggers**: Available via GitHub UI

### Artifacts
Each release includes:
- Ubuntu build with GCC 14
- Ubuntu build with Clang 20  
- Fedora build
- Launcher scripts for easy execution

## Initial Setup Steps

### 1. Repository Setup
```bash
# Clone or create your repository
git clone <your-repo-url>
cd ladybird-builder

# Add all files and push
git add .
git commit -m "Initial setup: Ladybird Builder GitHub Actions"
git push origin main
```

### 2. Verify Workflow
1. Go to your repository on GitHub
2. Navigate to **Actions** tab
3. You should see "Build and Release Ladybird Browser" workflow
4. The workflow will automatically run on push to main/master

### 3. First Build
The workflow will:
- Build Ladybird Browser on Ubuntu and Fedora
- Create release v1.0.0
- Upload binaries as release artifacts

## Configuration Options

### Modify Build Schedule
Edit `.github/workflows/build-and-release.yml`:
```yaml
schedule:
  - cron: '0 0,12 * * *'  # Change to your preferred schedule
```

### Custom Versioning
Use the version manager script:
```bash
# Set custom starting version
./scripts/version-manager.sh set v2.0.0

# Increment version manually
./scripts/version-manager.sh increment
```

### Add Distribution Support
Edit `.github/workflow-config.json` to add new distributions or modify dependencies.

## Testing the Setup

### Run Local Tests
```bash
./scripts/test-workflow.sh
```

### Test Version Management
```bash
./scripts/version-manager.sh current    # Show current version
./scripts/version-manager.sh next       # Show next version
./scripts/version-manager.sh increment  # Increment version
```

## Monitoring and Maintenance

### Check Workflow Status
- **GitHub Actions tab**: View workflow runs and logs
- **Releases section**: See created releases and download artifacts
- **Workflow insights**: Monitor performance and success rates

### Troubleshooting

#### Common Issues

1. **Workflow not triggering**
   - Check branch names (main/master)
   - Verify workflow file location
   - Ensure GitHub Actions are enabled

2. **Build failures**
   - Check build logs in Actions tab
   - Verify dependency installation
   - Check Ladybird build requirements

3. **Release creation issues**
   - Verify GITHUB_TOKEN permissions
   - Check version format
   - Review release creation logs

#### Manual Intervention

**Trigger workflow manually:**
1. Go to Actions → Build and Release Ladybird Browser
2. Click "Run workflow"
3. Select branch and run

**Force version reset:**
```bash
./scripts/version-manager.sh set v1.0.0
```

## Customization

### Add New Distributions
1. Add distribution configuration in `workflow-config.json`
2. Create new job in `build-and-release.yml`
3. Test with manual trigger

### Modify Build Process
- Edit dependency lists in configuration
- Adjust build commands in workflow
- Add post-build processing steps

### Extend Versioning
- Modify `scripts/version-manager.sh`
- Implement semantic versioning rules
- Add version validation

## Security Considerations

- **GitHub Token**: Uses default GITHUB_TOKEN with necessary permissions
- **Dependencies**: Only installs from official repositories
- **Artifacts**: Publicly available in releases
- **No sensitive data**: Workflow doesn't handle secrets

## Support

For issues with:
- **Ladybird Browser build**: Check [Ladybird documentation](https://github.com/LadybirdBrowser/ladybird)
- **GitHub Actions**: Refer to [GitHub Actions documentation](https://docs.github.com/en/actions)
- **Workflow configuration**: Review this setup guide and configuration files

## Next Steps

1. **Push repository** to GitHub
2. **Monitor first build** in Actions tab
3. **Download artifacts** from Releases section
4. **Customize configuration** as needed
5. **Set up notifications** for build status

The workflow is now ready to automatically build and release Ladybird Browser twice daily with proper version management!