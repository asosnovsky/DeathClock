function[res] = clean_table(table,gender,ethnic,maxage)
            com = [1 3 5; 2 4 6];
            res.lx = table(1:maxage,com(gender+1,ethnic+1)+6); %Number of people alive
            res.dx = table(1:maxage,com(gender+1,ethnic+1)); %Numbe of people who died in this period
            res.qx = table(1:maxage,com(gender+1,ethnic+1)+12); %Probability to die in one more year
    end