classdef ng
    % Matlab plotting convenience functions
    
    properties
        h = gobjects(1)
        template = []
        s = struct
        original = gobjects(1)
        children
    end
    
    properties (Hidden)
        new = true;
        
    end
    
    methods
        
        function obj = ng(varargin)
            h = gcf;
            t = 'default';
            for v = 1:numel(varargin)
                if isa(varargin{v}, 'char')
                    t = varargin{v};
                end
                if isa(varargin{v}, 'matlab.ui.Figure')
                    h = varargin{v};
                end
            end
            
            obj.template = t;
            obj.h = h;
            
            % Svae original figure, if creating new object
            if obj.new
                obj.original = copyobj(h, 0);
                obj.original.Visible = 'off';
            end 
            obj.new = false;
            
            % Set template defualts
            obj = obj.setDefaults;
            % Set specific template
            obj = obj.templates;
            % Apply template
            obj = obj.apply;
        end
        
        function h = get.children(obj)
            h = findobj(obj.h);
        end
        
        function obj = setDefaults(obj)
            % Set defaults
            
            % Figure positions
            obj.s.fPos = [1 1 800 600];
            
            % Axes fonts
            obj.s.aFontSize = 12;
            obj.s.aFontWeight = 'bold';
            obj.s.aTFSM = 1.25; % (TitleFontSizeMultiplier)
            % Axes lines
            obj.s.aLineWidth = 1.5;
            
            % Line (eg. as produced by PLOT) lines
            obj.s.lLineWidth = 1.3;
            
            % Bar graph line width
            obj.s.bLineWidth = 1.3;
            
            % Scatter markers
            obj.s.scMarkerSize = 60;
            obj.s.scFill = true;
            
            % Legend
            obj.s.lLoc = 'NorthWest';
            obj.s.lFontSize = 11;
            obj.s.lFontWeight = 'bold';
            
            % Grid
            obj.s.gr = 1;
            obj.s.grm = 0;
            
            % Scatter
            obj.s.scMarkerSize = 40;
        end
        
        function obj = apply(obj)
            % Get current figure
            f = obj.h;
            % Find bits in figure
            handles = findobj(f);
            
            % Run through these and set properties according to template
            for i = 1:length(handles)
                switch handles(i).Type
                    case 'figure'
                        % Set size
                        handles(i).Position = obj.s.fPos;
                        
                    case 'axes'
                        handles(i).TitleFontSizeMultiplier = obj.s.aTFSM;
                        handles(i).FontSize = obj.s.aFontSize;
                        handles(i).LineWidth = obj.s.aLineWidth;
                        handles(i).FontWeight = obj.s.aFontWeight;
                        
                        % Grid
                        if obj.s.gr
                            % Turn on major grid only
                            grid(handles(i), 'On')
                        end
                        
                        if obj.s.grm
                            % Turn on minor grid (and major)
                            handles(i).XMinorGrid = 'on';
                            % Tick labels are in
                            % handles(i).XRuler.MinorTickValues
                            if ~obj.s.gr
                                % Specifically hide the major grid, which
                                % just came on as well (not working)...
                                % This loses labels too:
                                % handles(i).XRuler.TickValues = []; And
                                % this doesn't do anything??
                                handles(i).GridAlpha = 0;
                            end
                        end
                        
                    case 'line'
                        handles(i).LineWidth = obj.s.lLineWidth;
                        
                    case 'bar'
                        handles(i).LineWidth = obj.s.bLineWidth;
                        % keyboard
                    case 'errorbar'
                        handles(i).LineWidth = obj.s.lLineWidth;
                        
                    case 'scatter'
                        handles(i).SizeData = obj.s.scMarkerSize;
                        
                        % Fill markers with edge color
                        if obj.s.scFill
                            handles(i).MarkerFaceColor = ...
                                handles(i).MarkerEdgeColor;
                        end
                        
                    case 'legend'
                        handles(i).FontSize = obj.s.lFontSize;
                        handles(i).Location = obj.s.lLoc;
                        handles(i).FontWeight = obj.s.lFontWeight;
                        
                    case 'text'
                        % Doesn't have any effect on suptitles
                        handles(i).FontSize = obj.s.lFontSize;
                end
            end
            
            drawnow
        end
        
        function obj = save(obj, fn)
            if exist('fn', 'var')
                ggraph.hgx(obj.h, fn)
            else
                ggraph.hgx(obj.h, 'Figure')
            end
        end
        
        function obj = reset(obj)
           close(obj.h)
           obj.h = copyobj(obj.original, 0);
           obj.h.Visible = 'on';
        end
        
        function showOriginal(obj)
            obj.original.Visible = 'on';
        end
        
        obj = templates(obj)
    end
    
    methods (Static)
        
        % Lazy figure saving
        hgx(varargin)
        
        % Turn openGL on
        og
        
        % Get MATLAB's default figure colours
        cols = getCols
        
    end
    
end