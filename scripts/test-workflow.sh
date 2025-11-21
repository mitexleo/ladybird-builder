#!/bin/bash

# Ladybird Builder Workflow Test Script
# This script tests various aspects of the GitHub Actions workflow configuration

set -e

echo "🧪 Ladybird Builder Workflow Test"
echo "=================================="

# Test 1: Check workflow file exists
echo "📋 Test 1: Checking workflow file..."
if [[ -f ".github/workflows/build-and-release.yml" ]]; then
    echo "✅ Workflow file exists"
else
    echo "❌ Workflow file missing"
    exit 1
fi

# Test 2: Check configuration file exists
echo "📋 Test 2: Checking configuration file..."
if [[ -f ".github/workflow-config.json" ]]; then
    echo "✅ Configuration file exists"
else
    echo "❌ Configuration file missing"
    exit 1
fi

# Test 3: Validate JSON configuration
echo "📋 Test 3: Validating JSON configuration..."
if command -v jq >/dev/null 2>&1; then
    if jq empty .github/workflow-config.json >/dev/null 2>&1; then
        echo "✅ JSON configuration is valid"
    else
        echo "❌ JSON configuration is invalid"
        exit 1
    fi
else
    echo "⚠️  jq not installed, skipping JSON validation"
fi

# Test 4: Check version manager script
echo "📋 Test 4: Checking version manager script..."
if [[ -f "scripts/version-manager.sh" ]]; then
    echo "✅ Version manager script exists"
    if [[ -x "scripts/version-manager.sh" ]]; then
        echo "✅ Version manager script is executable"
    else
        echo "❌ Version manager script is not executable"
        exit 1
    fi
else
    echo "❌ Version manager script missing"
    exit 1
fi

# Test 5: Test version manager functionality
echo "📋 Test 5: Testing version manager..."
./scripts/version-manager.sh current
./scripts/version-manager.sh next

# Test 6: Check directory structure
echo "📋 Test 6: Checking directory structure..."
directories=(".github" ".github/workflows" "scripts")
for dir in "${directories[@]}"; do
    if [[ -d "$dir" ]]; then
        echo "✅ Directory $dir exists"
    else
        echo "❌ Directory $dir missing"
        exit 1
    fi
done

# Test 7: Check README exists
echo "📋 Test 7: Checking documentation..."
if [[ -f "README.md" ]]; then
    echo "✅ README.md exists"
else
    echo "❌ README.md missing"
    exit 1
fi

# Test 8: Validate workflow YAML structure (basic check)
echo "📋 Test 8: Validating workflow structure..."
if grep -q "name: Build and Release Ladybird Browser" .github/workflows/build-and-release.yml; then
    echo "✅ Workflow name is correct"
else
    echo "❌ Workflow name is incorrect"
    exit 1
fi

if grep -q "on:" .github/workflows/build-and-release.yml; then
    echo "✅ Workflow triggers defined"
else
    echo "❌ Workflow triggers missing"
    exit 1
fi

# Test 9: Check for required jobs
echo "📋 Test 9: Checking required jobs..."
jobs=("build-ubuntu" "build-fedora" "create-release")
for job in "${jobs[@]}"; do
    if grep -q "$job:" .github/workflows/build-and-release.yml; then
        echo "✅ Job $job exists"
    else
        echo "❌ Job $job missing"
        exit 1
    fi
done

# Test 10: Check schedule configuration
echo "📋 Test 10: Checking schedule configuration..."
if grep -q "cron: '0 0,12 \* \* \*'" .github/workflows/build-and-release.yml; then
    echo "✅ Schedule configured for twice daily builds"
else
    echo "❌ Schedule configuration incorrect"
    exit 1
fi

echo ""
echo "🎉 All tests passed! The workflow configuration appears to be correct."
echo ""
echo "Next steps:"
echo "1. Push this repository to GitHub"
echo "2. The workflow will automatically run on the main/master branch"
echo "3. Check the Actions tab to monitor build progress"
echo "4. Releases will be created in the Releases section"
