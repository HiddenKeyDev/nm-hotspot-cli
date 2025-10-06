# Contributing to nm-hotspot-cli

Thank you for considering contributing to nm-hotspot-cli.

## Hacktoberfest

This project participates in Hacktoberfest. We welcome contributions from developers of all skill levels.

## How to Contribute

1. **Fork the repository**
2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/nm-hotspot-cli.git
   cd nm-hotspot-cli
   ```

3. **Create a new branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make your changes**
   - Write clean, readable code
   - Follow the existing code style
   - Test your changes thoroughly

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add: brief description of your changes"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Open a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Describe your changes clearly

## Commit Message Guidelines

- Use present tense ("Add feature" not "Added feature")
- Use imperative mood ("Move cursor to..." not "Moves cursor to...")
- Start with a capital letter
- Keep the first line under 50 characters
- Reference issues and pull requests when relevant

Examples:
- `Add: support for 5GHz band selection`
- `Fix: password validation bug`
- `Update: README with new examples`
- `Refactor: improve error handling`

## Testing

Before submitting a PR, please test your changes:

```bash
# Test basic functionality
./nm-hotspot create -s TestNet -p TestPass123
./nm-hotspot status
./nm-hotspot stop

# Test edge cases
./nm-hotspot create -s Test -p short  # Should fail
./nm-hotspot create -b invalid       # Should fail
```

## Code Style

- Use 4 spaces for indentation
- Follow bash best practices
- Add comments for complex logic
- Use meaningful variable names
- Keep functions focused and small

## Need Help?

- Check existing issues
- Look for issues labeled 'good first issue'
- Ask questions in issue comments

## What We're Looking For

- Bug fixes
- New features
- Documentation improvements
- Code refactoring
- Test coverage
- Performance improvements

Thank you for contributing.
