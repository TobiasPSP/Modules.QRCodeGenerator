@{
    Severity = @(
        'Error',
        'Warning'
    )
    IncludeRules = @(
        'PSAvoidUsingWriteHost',
        'PSAvoidUsingCmdletAliases',
        'PSAvoidUsingEmptyCatchBlock',
        'PSAvoidGlobalVars',
        'PSAvoidUsingInvokeExpression',
        'PSUseDeclaredVarsMoreThanAssignments',
        'PSUseCompatibleCommands',
        'PSUseConsistentIndentation',
        'PSUseConsistentWhitespace',
        'PSUseCorrectCasing',
        'PSUseLiteralInitializerForHashtable'
    )
    ExcludeRules = @(
        'PSAvoidTrailingWhitespace',
        'PSUseShouldProcessForStateChangingFunctions'
    )
    Rules = @{
        PSUseConsistentIndentation = @{
            Enable = $true
            IndentationSize = 4
            PipelineIndentation = 'IncreaseIndentationAfterEveryPipeline'
        }
        PSUseConsistentWhitespace = @{
            Enable = $true
            CheckInnerBrace = $true
            CheckOpenBrace = $true
            CheckOperator = $true
            CheckSeparator = $true
            CheckParameter = $true
        }
        PSUseCorrectCasing = @{
            Enable = $true
        }
    }
}