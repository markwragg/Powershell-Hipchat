@{
    ExcludeRules = @(
        'PSUseDeclaredVarsMoreThanAssignments'
        'PSAvoidTrailingWhitespace'
        'PSAvoidOverwritingBuiltInCmdlets'
    )

    Severity = @(
        "Warning"
        "Error"
    )

    Rules = @{}
}
