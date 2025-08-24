# Claude Code Session Management & Todo Tracking Guide

This guide helps engineers effectively manage Claude Code sessions and maximize productivity through structured todo tracking and progress management.

## Why Session Management Matters

Effective session management with Claude Code:

- Prevents losing track of complex multi-step tasks
- Provides visibility into progress for stakeholders  
- Ensures nothing gets forgotten during implementation
- Facilitates better handoffs between team members
- Creates accountability for completion of all requirements

## The TodoWrite Tool: Your Session Companion

Claude Code includes a powerful TodoWrite tool that helps track and manage tasks throughout your session. This tool should be used proactively for any non-trivial work.

### When to Use TodoWrite

**Always Use For:**

- Multi-step implementations (3+ distinct steps)
- Complex refactoring tasks
- Migration projects
- Feature development with multiple components
- Bug fixes that affect multiple files
- Tasks explicitly requested by user (e.g., "implement these features: A, B, C")

**Example Scenarios:**

```markdown
✅ "Add dark mode toggle with proper state management and CSS updates"
✅ "Refactor authentication system to use new JWT library"
✅ "Fix the checkout flow issues and run tests"
✅ "Help me implement user registration, product catalog, and shopping cart"

❌ "What's the current directory?"
❌ "Add a comment to this function"
❌ "How do I print 'Hello World' in Python?"
```

### Task Management Best Practices

#### 1. Task Creation

- Break complex tasks into specific, actionable items
- Use imperative form for task descriptions ("Fix authentication bug")
- Include both `content` and `activeForm` for clear communication
- Be specific about what needs to be accomplished

#### 2. Task States & Transitions

```markdown
pending → in_progress → completed
```

**Critical Rules:**

- Only ONE task can be `in_progress` at any time
- Mark tasks `completed` IMMEDIATELY after finishing
- Never batch completions - complete tasks as you finish them
- Only mark completed when fully accomplished (tests pass, no errors)

#### 3. Task Breakdown Strategy

```markdown
❌ Bad: "Implement user authentication"

✅ Good: 
- "Set up authentication database schema"
- "Create user registration API endpoint"  
- "Implement login functionality"
- "Add password reset feature"
- "Write authentication tests"
- "Update frontend to use new auth system"
```

## Session Planning Workflow

### 1. Session Initiation

```markdown
1. Understand the requirements clearly
2. Create initial todo list with TodoWrite
3. Break down complex tasks into manageable steps
4. Estimate scope and communicate expectations
```

### 2. During Implementation

```markdown
1. Mark current task as in_progress before starting work
2. Complete one task fully before moving to next
3. Mark completed immediately upon finishing
4. Add new tasks if discovered during implementation
5. Update task descriptions if scope changes
```

### 3. Session Conclusion

```markdown
1. Ensure all todos are completed or properly tracked
2. Run final validation (tests, linting, builds)
3. Summarize what was accomplished
4. Note any follow-up items for future sessions
```

## Real-World Examples

### Example 1: Feature Implementation

```markdown
User Request: "Add user profile editing with avatar upload"

Todo List:
- Create user profile edit form component
- Implement avatar upload with file validation  
- Add profile update API endpoint
- Update database schema for avatar storage
- Write tests for profile editing functionality
- Update navigation to include profile edit link
```

### Example 2: Bug Fix & Testing

```markdown
User Request: "Fix the shopping cart calculation bug and make sure tests pass"

Todo List:
- Investigate shopping cart calculation logic
- Fix tax calculation error in cart totals
- Fix shipping cost calculation for international orders
- Update unit tests for cart calculations
- Run full test suite and fix any failures
- Verify fix works in different scenarios
```

### Example 3: Migration Project

```markdown
User Request: "Migrate from REST API to GraphQL"

Todo List:
- Analyze current REST endpoints and data models
- Set up GraphQL server with Apollo
- Create GraphQL schemas for existing data models
- Implement GraphQL resolvers for user operations
- Implement GraphQL resolvers for product operations
- Update frontend to use GraphQL queries instead of REST
- Update authentication to work with GraphQL
- Migrate existing tests to work with GraphQL
- Update documentation and API guides
```

## Common Anti-Patterns to Avoid

### ❌ Poor Task Management

```markdown
- Generic tasks: "Fix the code"
- Batching completions: Marking multiple tasks complete at once
- Forgetting to update status: Tasks stuck in pending/in_progress
- No task breakdown: Single task for complex work
```

### ❌ Session Management Issues

```markdown
- Starting work without planning
- Not tracking progress visibly
- Abandoning todos mid-session
- Not documenting discovered issues
```

### ✅ Good Practices

```markdown
- Specific, actionable tasks
- Real-time status updates
- Immediate completion marking
- Proper task decomposition
- Clear communication of progress
```

## Integration with Development Workflow

### Git Integration

```bash
# Before starting work
git checkout -b feature/user-profile-edit

# During work (Claude Code will track progress)
# Commit frequently as todos are completed

# After completion
git push origin feature/user-profile-edit
# Use PR template that includes todo completion status
```

### Team Communication

```markdown
Daily Standup Template:
- Yesterday: Completed todos X, Y, Z using Claude Code
- Today: Working on todos A, B, C  
- Blockers: Waiting for database schema review before todo D

PR Description:
## Summary
Implemented user profile editing feature

## Completed Tasks
- ✅ Created user profile edit form component
- ✅ Implemented avatar upload with validation
- ✅ Added profile update API endpoint
- ✅ Updated database schema
- ✅ Added comprehensive tests
```

### Documentation Updates

Update your project's `CLAUDE.md` with session patterns:

```markdown
## Session Management
- Use TodoWrite for all multi-step tasks
- Break complex features into 5-7 manageable todos
- Always run tests and linting before marking tasks complete
- Update this file if new patterns emerge
```

## Troubleshooting Common Issues

### Issue: Tasks Not Getting Completed

**Symptoms:** Many tasks stuck in `in_progress` state
**Solutions:**

- Break down tasks into smaller, more manageable pieces
- Set clearer completion criteria
- Address blockers before moving forward

### Issue: Losing Track of Requirements

**Symptoms:** Missing functionality, incomplete implementation
**Solutions:**

- Create todos immediately when requirements are given
- Review original request against completed todos
- Add discovered requirements as new todos

### Issue: Inefficient Session Flow

**Symptoms:** Jumping between unrelated tasks, context switching
**Solutions:**

- Complete one todo fully before starting next
- Group related todos together
- Use `in_progress` to maintain focus

## Advanced Techniques

### Progressive Task Refinement

```markdown
Initial: "Implement authentication system"

Refined:
- "Research current authentication patterns in codebase"
- "Design JWT token structure and expiration strategy"  
- "Implement user registration with email verification"
- "Create secure login endpoint with rate limiting"
- "Add logout and token refresh functionality"
- "Integrate authentication with existing frontend routes"
- "Write comprehensive authentication tests"
- "Update API documentation for auth endpoints"
```

### Dependency Management

```markdown
Mark prerequisite relationships:
- "Set up database schema" (prerequisite)
  - "Create user registration endpoint" (depends on schema)
  - "Implement login functionality" (depends on schema)
```

### Scope Adjustment

```markdown
If scope changes during implementation:
1. Mark current task status appropriately
2. Add new tasks for expanded scope
3. Remove or modify tasks that are no longer relevant
4. Communicate scope changes to stakeholders
```

## Metrics and Improvement

### Session Effectiveness Metrics

- Todo completion rate per session
- Time from task creation to completion
- Number of scope changes per session
- Test success rate after implementation

### Continuous Improvement

- Review completed sessions for patterns
- Identify common bottlenecks or blockers
- Refine task breakdown strategies
- Share effective patterns with team

## Quick Reference

### TodoWrite Tool Commands

```markdown
# Create initial todo list
TodoWrite with array of task objects

# Update task status
Change status: pending → in_progress → completed

# Task object structure
{
  "content": "Imperative description of task",
  "status": "pending|in_progress|completed", 
  "activeForm": "Present continuous description"
}
```

### Session Checklist

- [ ] Requirements clearly understood
- [ ] Todo list created with specific tasks
- [ ] Tasks broken down to appropriate granularity
- [ ] One task marked in_progress at start
- [ ] Progress tracked and updated in real-time
- [ ] All tasks marked completed when finished
- [ ] Final validation completed (tests, builds, linting)
- [ ] Session results documented

Remember: Effective session management with TodoWrite is not overhead - it's the foundation of successful, trackable, and accountable development work with Claude Code.
