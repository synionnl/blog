Feature: Process

    Scenario: Do not use bot answer
        Given an asked question            
        When the bot answers the question with a probability smaller than 85%
        And the gateway with id "Gateway_UseBotAnswer" is executed
        Then the flow with id "Flow_UseBotAnswerNo" must be activated

    Scenario: Use bot answer
        Given an asked question            
        When the bot answers the question with a probability greater or equal to 85%
        And the gateway with id "Gateway_UseBotAnswer" is executed
        Then the flow with id "Flow_UseBotAnswerYes" must be activated

    Scenario: Review bot answer
        Given an asked question            
        When the bot answers the question with a probability greater or equal to 85% and smaller than 95%
        And the gateway with id "Gateway_ReviewBotAnswer" is executed
        Then the flow with id "Flow_ReviewBotAnswerYes" must be activated

    Scenario: Do not review bot answer
        Given an asked question            
        When the bot answers the question with a probability greater or equal to 95%
        And the gateway with id "Gateway_ReviewBotAnswer" is executed
        Then the flow with id "Flow_ReviewBotAnswerNo" must be activated
