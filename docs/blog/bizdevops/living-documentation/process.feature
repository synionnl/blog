Feature: Process

Scenario Outline: Gateway tests

  Given process "https://raw.githubusercontent.com/synionnl/website/4549e240500b5543addf1ff06e274fa4ed177e05/docs/blog/bizdevops/living-documentation/process.feature"
    And process has state "<state>"
   When the gateway with id "<gateway>" is executed
   Then the flow with id "<flow>" must be activated

  Examples: Scenarios
    | state                            | gateway                 | flow                    | 
    | { AnswerCorrectProbability: 84 } | Gateway_UseBotAnswer    | Flow_UseBotAnswerNo     | 
    | { AnswerCorrectProbability: 85 } | Gateway_UseBotAnswer    | Flow_UseBotAnswerYes    | 
    | { AnswerCorrectProbability: 94 } | Gateway_ReviewBotAnswer | Flow_ReviewBotAnswerYes | 
    | { AnswerCorrectProbability: 95 } | Gateway_ReviewBotAnswer | Flow_ReviewBotAnswerNo  | 
