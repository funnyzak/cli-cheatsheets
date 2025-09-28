# CLI Cheatsheets Project - Claude Assistant Guide

## Project Overview

This is a comprehensive command-line cheatsheet collection project that provides quick reference guides for various CLI tools, programming languages, and system utilities. The project consists of:

- **141+ cheatsheet files** covering 17 different categories
- **Interactive shell script** for easy access and navigation
- **Multiple deployment options** (remote execution, local usage, shell aliases)
- **Automated CI/CD pipelines** for releases and GitHub Pages deployment

## Project Structure

```
cli-cheatsheets/
├── cheatsheet.sh           # Main interactive script (22KB)
├── get-cheatsheet.sh       # Remote access script
├── README.md               # Comprehensive documentation
├── LICENSE                 # MIT License
├── .github/
│   └── workflows/
│       ├── release.yml     # Automated release workflow
│       └── github-pages.yml # Pages deployment workflow
└── cheatsheets/            # Cheatsheet collection (17 categories)
    ├── android/           # Android development tools
    ├── build/             # Build tools (CMake, Gradle, Maven, etc.)
    ├── cli/               # Command-line interface tools
    ├── cloud/             # Cloud platform tools
    ├── container/         # Containerization tools (Docker, kubectl, Podman)
    ├── data-process/      # Data processing tools (jq, yq, awk, sed, cut)
    ├── database/          # Database clients
    ├── media/             # Media processing tools
    ├── network/           # Networking tools
    ├── notification/      # Notification services (Apprise)
    ├── os/                # Operating system commands
    ├── package/           # Package managers
    ├── runtime/           # Runtime environments
    ├── security/          # Security tools
    ├── tools/             # Miscellaneous tools (bat, exa, tldr)
    ├── version-control/    # Version control systems
    └── webserver/         # Web server management
```

## Cheatsheet Format

All cheatsheets follow a consistent format:

1. **Header Section**:
   - Tool name and description
   - Project URL
   - Comment blocks with legends/variables

2. **Categorized Commands**:
   - Logical grouping by functionality
   - Clear section headers with comment blocks
   - Inline comments explaining options

3. **Variable Legend**:
   - `<variable>` format for placeholders
   - Clear descriptions of each variable
   - Example values where helpful

### Recent Additions Examples

**Container Tools:**
- `kubectl-cheatsheet.txt`: Kubernetes cluster management commands
- `podman-cheatsheet.txt`: Podman containerization tool commands

**Data Processing Tools:**
- `awk-cheatsheet.txt`: Text processing and pattern scanning
- `sed-cheatsheet.txt`: Stream text editor commands
- `cut-cheatsheet.txt`: Text column extraction commands

**Tools Category:**
- `bat-cheatsheet.txt`: Enhanced cat command with syntax highlighting
- `exa-cheatsheet.txt`: Modern ls replacement with better UX

Example structure:
```bash
##############################################################################
# Tool Name Cheatsheet
# https://github.com/funnyzak/cli-cheatsheets
##############################################################################

# Legend:
#   <file>      : File path
#   <option>    : Command option

##############################################################################
# Category Name
##############################################################################

command --option <file>    # Description of command
```

## Main Script Features

The `cheatsheet.sh` script provides:

### Core Functionality
- **Interactive menu system** with category-based navigation
- **Direct command access** (`./cheatsheet.sh git`)
- **Command listing** (`./cheatsheet.sh -l`)
- **Help system** (`./cheatsheet.sh -h`)

### Environment Variables
- `CLI_CHEATSHEET_PATH`: Custom cheatsheet directory path
- `CLI_CHEATSHEET_CACHE_DIR`: Temporary cache directory
- `CLI_CHEATSHEET_REGION`: Set to "cn" for China region URLs

### URL Management
- **Default URL**: GitHub raw content
- **China mirror**: Gitee mirror for faster access
- **Custom URL support**: Override default URLs

### Shell Integration
- Bash/Zsh alias support
- Fish shell function template
- Interactive menu support in aliases

## Development Workflow

### Adding New Cheatsheets

1. **Choose appropriate category** in `cheatsheets/`
2. **Create file** with format `[tool]-cheatsheet.txt`
3. **Follow existing format** and conventions
4. **Update main script** with command metadata if needed
5. **Test thoroughly** before submitting PR

### Script Development

1. **Main script** is heavily commented in Chinese
2. **Uses associative arrays** for command metadata
3. **Implements robust error handling** with `set -euo pipefail`
4. **Supports both local and remote execution**

### Testing Checklist

Before committing changes:

```bash
# Test script functionality
./cheatsheet.sh -h                    # Help system
./cheatsheet.sh -l                    # Command listing
./cheatsheet.sh git                   # Specific command
./cheatsheet.sh                       # Interactive menu

# Test remote execution
curl -s ... | bash -s -- git

# Test with custom paths
CLI_CHEATSHEET_PATH=./test ./cheatsheet.sh git
```

## CI/CD Pipeline

### Release Workflow (`.github/workflows/release.yml`)
- **Triggers**: Push to main/dev branches or manual dispatch
- **Packaging**: Creates tar.gz with cheatsheets, script, and README
- **GitHub Releases**: Automatic release creation
- **Notifications**: Apprise integration for deployment alerts

### Pages Deployment (`.github/workflows/github-pages.yml`)
- **Triggers**: Push to main/dev branches or tags
- **Deployment**: GitHub Pages with custom domain (cs.yycc.dev)
- **Content**: README.md and get-cheatsheet.sh as index.html

## Usage Patterns

### For Users
1. **Remote execution** (recommended):
   ```bash
   curl https://cs.yycc.dev | bash -s -- git
   ```

2. **Shell aliases** (convenient):
   ```bash
   alias cs='curl -s ... | bash -s -- "$@"'
   cs git
   ```

3. **Local usage** (offline):
   ```bash
   git clone https://github.com/funnyzak/cli-cheatsheets
   cd cli-cheatsheets
   ./cheatsheet.sh
   ```

### For Contributors
1. **Fork the repository**
2. **Create feature branch**
3. **Add/update cheatsheets**
4. **Test changes thoroughly**
5. **Submit pull request**

## Key Technical Details

### Script Architecture
- **Bash associative arrays** for command metadata
- **Modular function design** for maintainability
- **Error handling** with proper exit codes
- **Cross-platform compatibility** (Linux, macOS)

### File Organization
- **Category-based structure** for logical grouping
- **Consistent naming**: `[tool]-cheatsheet.txt`
- **Hierarchical organization** with clear separation

### Performance Considerations
- **Caching mechanism** for remote content
- **Efficient file searching** with organized structure
- **Minimal dependencies** - bash only

## Common Tasks

### Adding a New Tool
1. Identify appropriate category from the 17 available categories
2. Create cheatsheet file with format `[tool]-cheatsheet.txt`
3. Follow established format and conventions
4. Add to COMMANDS array in main script if needed
5. Test integration thoroughly
6. Update README.md documentation
7. Submit PR

### Updating Existing Cheatsheet
1. Locate file in appropriate category
2. Update content following format
3. Verify accuracy of commands
4. Test changes with script
5. Update README.md if adding new tools
6. Submit PR

### Documentation Updates
1. Update README.md with new cheatsheets (counts and descriptions)
2. Update CLAUDE.md with project changes
3. Verify category listings are complete
4. Test that all documented tools exist in filesystem

### Script Maintenance
1. Review and update command registry
2. Optimize performance bottlenecks
3. Improve error handling
4. Update documentation
5. Test cross-platform compatibility
6. Ensure all 141+ cheatsheets are accessible

## Project Guidelines

### Code Standards
- **Follow existing formatting** and conventions
- **Use consistent commenting** style
- **Maintain backward compatibility**
- **Test thoroughly** before changes

### Content Standards
- **Accurate and up-to-date** commands
- **Clear explanations** and examples
- **Logical organization** within categories
- **Comprehensive coverage** of common use cases

### Community Guidelines
- **Be respectful** and constructive
- **Provide clear PR descriptions**
- **Respond to review feedback**
- **Help maintain quality standards**

## Troubleshooting

### Common Issues
1. **Permission denied**: Ensure script is executable (`chmod +x`)
2. **File not found**: Check `CLI_CHEATSHEET_PATH` environment variable
3. **Network issues**: Try China mirror with `CLI_CHEATSHEET_REGION=cn`
4. **Interactive menu issues**: Use temporary file approach for aliases

### Debug Mode
Enable debug output by examining the script's error handling and logging mechanisms.

## Future Enhancements

### Potential Improvements
1. **Command search functionality**
2. **Cheatsheet rating system**
3. **User-contributed examples**
4. **Integration with man pages**
5. **Web interface**
6. **Mobile app companion**

### Technical Debt
1. **Script refactoring** for better modularity
2. **Improved error messages**
3. **Configuration file support**
4. **Plugin architecture**

## Resources

### Project Links
- **GitHub Repository**: https://github.com/funnyzak/cli-cheatsheets
- **Live Demo**: https://cs.yycc.dev
- **Documentation**: README.md in repository
- **China Mirror**: https://gitee.com/funnyzak/cli-cheatsheets

### Related Tools
- **tldr**: Simplified man pages (also included in this project)
- **cheat**: Command cheatsheet tool
- **navi**: Interactive command cheatsheet
- **eg**: Examples of commands
- **bat**: Enhanced cat command (included in tools/)
- **exa**: Modern ls replacement (included in tools/)

### Standards and Conventions
- **Shell scripting best practices**
- **CLI design patterns**
- **Documentation standards**
- **Open source guidelines**
- **Consistent file naming**: `[tool]-cheatsheet.txt`
- **Category-based organization** with clear separation

---

## Current Project Statistics (as of 2025)

- **Total Cheatsheets**: 141+ files
- **Categories**: 17 comprehensive categories
- **Recent Additions**: kubectl, podman, awk, sed, cut, bat, exa
- **Script Size**: 22KB main interactive script
- **Deployment**: GitHub Pages with custom domain
- **CI/CD**: Automated releases and deployment workflows

This guide provides a comprehensive overview of the CLI Cheatsheets project for Claude assistants working on the codebase. Follow the established patterns and conventions when contributing to maintain consistency and quality across the project.