Feature: Process

    Scenario: Do not use bot answer
        Given an asked question            
        When the bot answers the question with a probaility smaller then 85%
        And the gateway "Gateway_UseBotAnswer" is executed
        Then the flow "Flow_UseBotAnswerNo" must be activated

    Scenario: Use bot answer
        Given an asked question            
        When the bot answers the question with a probaility greater or equal then 85%
        And the gateway "Gateway_UseBotAnswer" is executed
        Then the flow "Flow_UseBotAnswerYes" must be activated

    Scenario: Review bot answer
        Given an asked question            
        When the bot answers the question with a probaility greater or equal then 85% and smaller then 95%
        And the gateway "Gateway_ReviewBotAnswer" is executed
        Then the flow "Flow_ReviewBotAnswerYes" must be activated

    Scenario: Do not review bot answer
        Given an asked question            
        When the bot answers the question with a probaility greater or equal then 95%
        And the gateway "Gateway_ReviewBotAnswer" is executed
        Then the flow "Flow_ReviewBotAnswerNo" must be activated
