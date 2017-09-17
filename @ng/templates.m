function obj = templates(obj)

switch lower(obj.template)
    case 'default'
        % Leave as is
    case 'wide'
        % Change position to make figue wider
        % Otherwise as default
        obj.s.fPos = [1 1 1200 600];
    case '800'
        obj.s.fPos = [1 1 800 600];
    case 'small'
        obj.s.fPos = [1 1 640 480];
    case '1024'
        obj.s.fPos = [1 1 1024 768];
        obj.s.lLineWidth = 2;
        obj.s.lFontSize = 18;
        obj.s.aFontSize = 18;
        obj.s.aFontWeight = 'bold';
    case '1024ne'
        obj.s.fPos = [1 1 1024 768];
        obj.s.lLineWidth = 2;
        obj.s.lFontSize = 18;
        obj.s.aFontSize = 18;
        obj.s.aFontWeight = 'bold';
        obj.s.lLoc = 'NorthEast';
    case '1024thinlines'
        obj.s.fPos = [1 1 1024 768];
        obj.s.lLineWidth = 1;
        obj.s.lFontSize = 13;
        obj.s.aFontSize = 13;
        obj.s.aFontWeight = 'bold';
    case 'big'
        % Change position to make figue wider
        % Otherwise as default
        obj.s.fPos = [1 1 1200 1200];
    case 'huge'
        obj.s.fPos = [1 1 1800 1800];
    case 'gridminor'
        obj.s.gr = 0;
        obj.s.grm = 1;
        obj.s.fPos = [1 1 1025 769];
    case '...' % Define new templates here
    otherwise
        disp('Template not found, only applying defaults.')
end