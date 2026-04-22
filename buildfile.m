function plan = buildfile
    plan = buildplan(localfunctions);
    plan("test").Dependencies = "codeIssues";
    plan.DefaultTasks = "test";
end

function codeIssuesTask(~)
    issues = codeIssues(pwd, IncludeSubfolders=true);
    errors = issues.Issues(issues.Issues.Severity == "error", :);
    assert(height(errors) == 0, "Found %d code errors", height(errors));
end

function testTask(~)
    results = runtests(pwd, IncludeSubfolders=true);
    assertSuccess(results);
end
