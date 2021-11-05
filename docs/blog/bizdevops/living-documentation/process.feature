Feature: Process

    Scenario: Do not use bot answer
        Given an asked question            
        When the bot answers the question with a probaility of "84%"
        Then the answer question task must be activated

    Scenario: Review bot answer
        Given an asked question            
        When the bot answers the question with a probaility between "85%" and "95%"
        Then the review anwser task must be activated

    Scenario: Send bot answer
        Given an asked question            
        When the bot answers the question with a probaility of "95%" or higher
        Then the send answer task must be activated
