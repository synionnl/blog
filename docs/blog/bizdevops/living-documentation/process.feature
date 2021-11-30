Feature: Process

Scenario: Do not use bot answer
  Given an asked question            
    And the bot answers the question with a probability smaller than 85%
   When the gateway with id "Gateway_UseBotAnswer" is executed
   Then the flow with id "Flow_UseBotAnswerNo" must be activated

Scenario: Use bot answer
  Given an asked question            
    And the bot answers the question with a probability greater or equal to 85%
   When the gateway with id "Gateway_UseBotAnswer" is executed
   Then the flow with id "Flow_UseBotAnswerYes" must be activated

Scenario: Review bot answer
  Given an asked question            
    And the bot answers the question with a probability greater or equal to 85% and smaller than 95%
   When the gateway with id "Gateway_ReviewBotAnswer" is executed
   Then the flow with id "Flow_ReviewBotAnswerYes" must be activated

Scenario: Do not review bot answer
  Given an asked question            
    And the bot answers the question with a probability greater or equal to 95%
   When the gateway with id "Gateway_ReviewBotAnswer" is executed
   Then the flow with id "Flow_ReviewBotAnswerNo" must be activated

Scenario Outline: Generic test

  Given process has state <state>
   When the gateway with id <gateway> is executed
   Then the flow wih id <flow> must be activated

  Examples: 
    | state                            | gateway                 | flow                    | 
    | { AnswerCorrectProbability: 84 } | Gateway_UseBotAnswer    | Flow_UseBotAnswerNo     | 
    | { AnswerCorrectProbability: 85 } | Gateway_UseBotAnswer    | Flow_UseBotAnswerYes    | 
    | { AnswerCorrectProbability: 94 } | Gateway_ReviewBotAnswer | Flow_ReviewBotAnswerYes | 
    | { AnswerCorrectProbability: 95 } | Gateway_ReviewBotAnswer | Flow_ReviewBotAnswerNo  |