classdef tMyApp < matlab.unittest.TestCase
    properties
        App
    end

    methods (TestMethodSetup)
        function launchApp(testCase)
            testCase.App = MyApp;
            testCase.addTeardown(@delete, testCase.App);
        end
    end

    methods (Test)
        function testAppCreation(testCase)
            testCase.verifyTrue(isvalid(testCase.App.UIFigure), ...
                'App UIFigure should be valid.');
            testCase.verifyEqual(testCase.App.UIFigure.Name, 'Simple Calculator', ...
                'App title should be "Simple Calculator".');
        end

        function testComponentsExist(testCase)
            testCase.verifyNotEmpty(testCase.App.AddButton, 'Add button should exist.');
            testCase.verifyNotEmpty(testCase.App.ResetButton, 'Reset button should exist.');
            testCase.verifyNotEmpty(testCase.App.ResultLabel, 'Result label should exist.');
            testCase.verifyNotEmpty(testCase.App.Input1, 'Input1 should exist.');
            testCase.verifyNotEmpty(testCase.App.Input2, 'Input2 should exist.');
        end

        function testAddition(testCase)
            testCase.App.Input1.Value = 3;
            testCase.App.Input2.Value = 7;
            % Simulate button press
            testCase.App.AddButton.ButtonPushedFcn();
            testCase.verifyEqual(testCase.App.ResultLabel.Text, 'Result: 10.00', ...
                'Adding 3 + 7 should display "Result: 10.00".');
        end

        function testReset(testCase)
            testCase.App.Input1.Value = 5;
            testCase.App.Input2.Value = 3;
            testCase.App.AddButton.ButtonPushedFcn();
            % Now reset
            testCase.App.ResetButton.ButtonPushedFcn();
            testCase.verifyEqual(testCase.App.Input1.Value, 0, 'Input1 should be 0 after reset.');
            testCase.verifyEqual(testCase.App.Input2.Value, 0, 'Input2 should be 0 after reset.');
            testCase.verifyEqual(testCase.App.ResultLabel.Text, 'Result: 0.00', ...
                'Result should be "Result: 0.00" after reset.');
        end
    end
end
