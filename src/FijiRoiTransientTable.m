classdef FijiRoiTransientTable
    % FIJIROITRANSIENTTABLE - Table of measurements from ROI drawn in FIJI

    properties (SetAccess = immutable)
        % PATH - Path to file
        Path
    end

    properties (Dependent)
        % FILENAME - Name of file from path
        Filename 
    end

    properties (Access = protected)
        % DATA - Tall table data from file
        Data 
    end

    methods 
        function T = FijiRoiTransientTable(filepath)
            % Constructs object from path
            arguments
                filepath (1,1) string 
            end
            % Do not do mustBeFile for sake of back compatibility
            assert(isfile(filepath),'FijiRoiTransientTable:nullFile',...
                'File must exist!')
            assert(endsWith(filepath,'ROI.csv','IgnoreCase',true) || ...
                endsWith(filepath,'ROIs.csv','IgnoreCase',true),...
                'FijiRoiTransientTable:nullFile',...
                'File must end with ROI or ROI!')
            T.Path = filepath;
            % Construct tabularTextDatastore from file
            ds = tabularTextDatastore(filepath);
            % For sake of ensuring Fiji interoperability, 
            % check that Var1 and Label are variables
            %%%FIXME: Add more variables to ensure that 
            %%% we account for whole gammut of measurement options
            pat = ["Var1","Label","RawIntDen","IntDen"];
            assert(all(contains(ds.VariableNames,pat)),...
                'FijiRoiTransientTable:badColumnNames',...
                ['Column names must contain Var1 or Label! \n ',...
                'Please re-apply measurement in FIJI with those options checked!']);
            % Now, wrap datastore with tall
            T.Data = tall(ds);
        end
    end
end