function [results] = computelife(tables,PARAMS)
%% HELP
%   TABLE_DIR : Directory of tables
%   PARAMS : Should include an object of all required parameters
%   EXAMPLE:
%       PARAMS.general = 1;
%       PARAMS.age = 10;
%       PARAMS.ethnic = 1; %% 0 = white, 1 = black, 2= asian
%       PARAMS.gender = 0; %% 0 = male, 1 = female
%       PARAMS.preg = 0; %% 0 = FALSE, 1 = TRUE
%       PARAMS.drive = 1; %% 0 = FALSE, 1 = TRUE
%       PARAMS.asthma = 1; %% 0 = FALSE, 1 = TRUE
%       PARAMS.smoking = 2; %% 0 = rarely, 1=sometimes, 2=often
%       PARAMS.alcohol = 2; %% 0 = rarely, 1=sometimes, 2=often
%       PARAMS.swim = 1; %% 0 = rarely, 1=sometimes, 2=often
%       PARAMS.travel = 1; %% 0 = rarely, 1=sometimes, 2=often
%       test = computelife(tables,PARAMS);
%           test = 
%           
%                         table: [1x1 struct]
%                  expected_age: 91.4022
%               expected_return: 'none'
%
%% Display what was loaded and set Base variables
    agelist = [1,4:5:100,100];%The data is given in intervals of 5
    %   Approximate Age 
        [ageid ageid] = min(abs(agelist-PARAMS.age));
        age = agelist(ageid);%approximated age
    if ~(exist('tables'))
        error(message('tables, DOES NOT EXISTS! '));
    end
    types = fieldnames(tables);%Name of loaded tables
    disp('using the following tables:');%Display names of loaded tables
    disp(types);
    disp('using the following parameter:');%Display names of loaded parameter
    disp(PARAMS);
    
%%  Determine Max Age and Show Error if sizes are 0 or do not match
    disp('determining max age...');
    maxage = 0;%Set base age to 0
    for i = 1:numel(types)
        if maxage <= length(tables.(types{i}));%save the largest of values
            maxage = length(tables.(types{i}));
        else
            if i > 1%let us know if the sizes don't match or if there is a 0 length table
                error(message(strcat('Not all tables have the same length, eg:',types{i},' and ', types{i-1})));
            else 
                error(message(strcat('The following has length 0:',types{1})));
            end
        end
    end
    
%%  Clean Table Function
    function[res] = clean_table(table,gender,ethnic,maxage)
            com = [1 3 5; 2 4 6];%These values are standardized table values
            res.lx = table(1:maxage,com(gender+1,ethnic+1)+6); %Number of people alive
            res.dx = table(1:maxage,com(gender+1,ethnic+1)); %Numbe of people who died in this period
            res.qx = table(1:maxage,com(gender+1,ethnic+1)+12); %Probability to die in one more year
    end

%%	Clean Tables and Select Tables
    disp('Cleaning Tables...');
    for i = 1:numel(types)
        disp(strcat(num2str(i),'/',num2str(numel(types)),' tables cleaned'));
        if ~(strcmp(types{i},'general')||size(tables.(types{i}),2)<18)%needs to be cleaned differently
            tables.(types{i}) = clean_table(tables.(types{i}),PARAMS.gender,PARAMS.ethnic,maxage);%saves a clean table for the i'th table
        end 
        if ~(strcmp(types{i},'general')||size(tables.(types{i}),2)~=6)%needs to be cleaned differently, no ethnic groups
            table = tables.(types{i});
            tables.(types{i}).lx = table(1:maxage,PARAMS.gender+1); %Number of people alive
            tables.(types{i}).dx = table(1:maxage,PARAMS.gender+3); %Numbe of people who died in this period
            tables.(types{i}).qx = table(1:maxage,PARAMS.gender+5); %Probability to die in one more year
        end  
    end
    types = fieldnames(tables);
    disp('Selecting tables based on category');
    for i = 1:numel(types)
        if PARAMS.(types{i}) == 0
            tables=rmfield(tables,types{i});
        end
    end
    types = fieldnames(tables);
%%  Multiple Life table
    disp('using the following tables:');
    disp(types);
    disp('Building Multiple Life Table...');
    table = struct('lx',tables.general(1:maxage,1),'dx',tables.general(1:maxage,2),'px',(1-tables.general(1:maxage,3)));%Define an 'empty' multiple life table as the general
    %Please note that 'px' is the probability of a person age 'x' surviving 1
    %more year
    for i = 1:numel(types)
        if ~(strcmp(types{i},'general'))%already defined
            for j = 1:maxage
                table.lx(j) = table.lx(j) + tables.(types{i}).lx(j);%add all lives
                table.dx(j) = table.dx(j) + tables.(types{i}).dx(j);%add all deaths
                table.px(j) = table.px(j)*(1-tables.(types{i}).qx(j));%multiple all probablities (their are independent)
            end
        end
    end
%% Compute expected age
disp('Computing expected age...');
expected_age = sum( 5 * table.px(ageid:maxage) )+ age;%Sum of all probabilities to survive 5 years at given age

%%  Compute expected return
disp('Computing expected return...');
%   Computation
expected_return = PARAMS.premium*(1+PARAMS.intrest)^expected_age;
%   Stylze
expected_return = sprintf('$%.2f', expected_return);
expected_return(2, length(expected_return) - 6:-3:2) = ',';
expected_return = transpose(expected_return(expected_return ~= char(0)));

%%  Results
results.table = table;
results.tables = tables;
results.expected_age = expected_age;
results.expected_return = expected_return;
disp('Done!');
disp(results);
end