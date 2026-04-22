classdef MyApp < matlab.apps.AppBase

    properties (Access = public)
        UIFigure     matlab.ui.Figure
        GridLayout   matlab.ui.container.GridLayout
        AddButton    matlab.ui.control.Button
        ResetButton  matlab.ui.control.Button
        ResultLabel  matlab.ui.control.Label
        Input1       matlab.ui.control.NumericEditField
        Input2       matlab.ui.control.NumericEditField
    end

    properties (Access = private)
        CurrentResult double = 0
    end

    methods (Access = private)
        function addButtonPushed(app, ~)
            app.CurrentResult = app.Input1.Value + app.Input2.Value;
            app.ResultLabel.Text = sprintf('Result: %.2f', app.CurrentResult);
        end

        function resetButtonPushed(app, ~)
            app.Input1.Value = 0;
            app.Input2.Value = 0;
            app.CurrentResult = 0;
            app.ResultLabel.Text = 'Result: 0.00';
        end
    end

    methods (Access = private)
        function createComponents(app)
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 300 200];
            app.UIFigure.Name = 'Simple Calculator';

            app.GridLayout = uigridlayout(app.UIFigure, [4, 2]);

            app.Input1 = uieditfield(app.GridLayout, 'numeric');
            app.Input1.Layout.Row = 1; app.Input1.Layout.Column = 1;

            app.Input2 = uieditfield(app.GridLayout, 'numeric');
            app.Input2.Layout.Row = 1; app.Input2.Layout.Column = 2;

            app.AddButton = uibutton(app.GridLayout, 'push');
            app.AddButton.Layout.Row = 2; app.AddButton.Layout.Column = 1;
            app.AddButton.Text = 'Add';
            app.AddButton.ButtonPushedFcn = @(~,~) addButtonPushed(app);

            app.ResetButton = uibutton(app.GridLayout, 'push');
            app.ResetButton.Layout.Row = 2; app.ResetButton.Layout.Column = 2;
            app.ResetButton.Text = 'Reset';
            app.ResetButton.ButtonPushedFcn = @(~,~) resetButtonPushed(app);

            app.ResultLabel = uilabel(app.GridLayout);
            app.ResultLabel.Layout.Row = 3; app.ResultLabel.Layout.Column = [1 2];
            app.ResultLabel.Text = 'Result: 0.00';

            app.UIFigure.Visible = 'on';
        end
    end

    methods (Access = public)
        function app = MyApp()
            createComponents(app);
            registerApp(app, app.UIFigure);
            if nargout == 0
                clear app
            end
        end

        function delete(app)
            delete(app.UIFigure);
        end
    end
end
