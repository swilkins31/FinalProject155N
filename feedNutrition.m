function [] = feedNutrition()
    close all;
    global gui;
    gui.fig = figure('Name','Feed Nutrition'); %creates a figure
    
    %heading of the column that will contain all feed ingredients
    gui.feedHeading = uicontrol('style','text','units','normalized','position',[0.06 0.85 0.15 0.1],'string','Feedstuff','horizontalalignment','left');
    
    %display of every feed ingredient
    gui.wholeCorn = uicontrol('style','text','units','normalized','position',[0.06 0.77 0.15 0.1],'string','Whole Corn','horizontalalignment','left');
    gui.rolledCorn = uicontrol('style','text','units','normalized','position',[0.06 0.69 0.15 0.1],'string','Rolled Corn','horizontalalignment','left');
    gui.cornDDG = uicontrol('style','text','units','normalized','position',[0.06 0.61 0.25 0.1],'string','Corn Dried Distillers Grain','horizontalalignment','left');
    gui.oatGrain = uicontrol('style','text','units','normalized','position',[0.06 0.53 0.15 0.1],'string','Oat Grain','horizontalalignment','left');
    gui.caneMolasses = uicontrol('style','text','units','normalized','position',[0.06 0.45 0.15 0.1],'string','Cane Molasses','horizontalalignment','left');
    gui.soyHulls = uicontrol('style','text','units','normalized','position',[0.06 0.37 0.15 0.1],'string','Soybean Hulls','horizontalalignment','left');
    gui.soyMeal = uicontrol('style','text','units','normalized','position',[0.06 0.29 0.15 0.1],'string','Soybean Meal','horizontalalignment','left');
    gui.sunflowerMeal = uicontrol('style','text','units','normalized','position',[0.06 0.21 0.15 0.1],'string','Sunflower Meal','horizontalalignment','left');

    %heading for the column for entering quantity of each ingredient
    gui.enterHeading = uicontrol('style','text','units','normalized','position',[0.32 0.85 0.25 0.1],'string','Percentage of Ingredient','horizontalalignment','left');
    
    %creates text boxes for users to enter percentage of each ingredient in
    %the mix, callback function allows us to display a running total of the percentage accounted for in the mix   
    for i = 1:8
       gui.editBox(i) = uicontrol('style','edit','units','normalized','position',[0.32 (0.92-(0.08*i)) 0.09 0.05],'string','0','callback',{@displayTotal}); 
       
    end
    
    
    %create a reset button, use a callback function to perform the actual
    %reset
    gui.resetButton = uicontrol('style','pushbutton','units','normalized','position',[0.32 0.09 0.12 0.05],'string','Reset','callback',{@reset});

    %put a running total below the edit boxes
    gui.labelTotal = uicontrol('style','text','units','normalized','position',[0.32 0.14 0.15 0.1],'string','Total:','horizontalalignment','left');
    gui.runningTotal = uicontrol('style','text','units','normalized','position',[0.39 0.14 0.15 0.1],'string','0','horizontalalignment','left');
    
    %create a calculate button, a callback function will actually calculate
    %the nutrition facts of the feed mix
    gui.calculateButton = uicontrol('style','pushbutton','units','normalized','position',[0.73 0.62 0.12 0.05],'string','Calculate','callback',{@calculate});
    
    %here is the callback function that displays the running total
    function [] = displayTotal(~,~)
       total = 0;
       for i = 1:8
          %for each edit box, add the amount entered to the sum of
          %everything else that has been entered in every other edit box
          total = total + str2double(gui.editBox(i).String); 
       end
       %updates the running total text
       gui.runningTotal.String = total;
    end

    %here is the callback for resetting everything, it's pretty simple
    %everything that displayed a number is set back to zero
    function [] = reset(~,~)
        for i = 1:8
            gui.editBox(i).String = 0;
        end
        gui.runningTotal.String = 0;
        gui.TDN.String = 0;
        gui.CP.String = 0;
        gui.CF.String = 0;
        gui.EE.String = 0;
        gui.Ash.String = 0; 
    end

    %here is the callback function for actually calculating the nutritional
    %facts of the feed mix
    function [] = calculate(~,~)
    
    %all of this is just creating the space where we will display the
    %different nutrition facts, more info on the nutritional values below
    gui.labelTDN = uicontrol('style','text','units','normalized','position',[0.62 0.45 0.20 0.1],'string','Total Digestible Nutrients (Energy)','horizontalalignment','left');
    gui.TDN = uicontrol('style','text','units','normalized','position',[0.85 0.45 0.15 0.1],'string','0','horizontalalignment','left');
    
    gui.labelCP = uicontrol('style','text','units','normalized','position',[0.62 0.37 0.15 0.1],'string','Crude Protein','horizontalalignment','left');
    gui.CP = uicontrol('style','text','units','normalized','position',[0.85 0.37 0.15 0.1],'string','0','horizontalalignment','left');
    
    gui.labelCF = uicontrol('style','text','units','normalized','position',[0.62 0.29 0.15 0.1],'string','Crude Fiber','horizontalalignment','left');
    gui.CF = uicontrol('style','text','units','normalized','position',[0.85 0.29 0.15 0.1],'string','0','horizontalalignment','left');
    
    gui.labelEE = uicontrol('style','text','units','normalized','position',[0.62 0.21 0.20 0.1],'string','Ether Extract (Crude Fat Content)','horizontalalignment','left');
    gui.EE = uicontrol('style','text','units','normalized','position',[0.85 0.21 0.15 0.1],'string','0','horizontalalignment','left');
    
    gui.labelAsh = uicontrol('style','text','units','normalized','position',[0.62 0.13 0.20 0.1],'string','Total Mineral Content','horizontalalignment','left');
    gui.Ash = uicontrol('style','text','units','normalized','position',[0.85 0.13 0.15 0.1],'string','0','horizontalalignment','left');    
    
    %these global variables are the percentage of each ingredient that was
    %entered by the user, they will be used in out weighted calculation
    %below
    gui.percWholeCorn = str2double(gui.editBox(1).String);
    gui.percRolledCorn = str2double(gui.editBox(2).String);
    gui.percDDG = str2double(gui.editBox(3).String);
    gui.percOats = str2double(gui.editBox(4).String);
    gui.percMolasses = str2double(gui.editBox(5).String);
    gui.percSoyHulls = str2double(gui.editBox(6).String);
    gui.percSoyMeal = str2double(gui.editBox(7).String);
    gui.percSunflower = str2double(gui.editBox(8).String);
    
    %all of these values for the nutritional facts of each ingredient were
    %found in an online table that can be found via this website:
    %https://www.beefmagazine.com/nutrition/feed-composition-tables-how-use-2017-data-mix-best-feed-your-cattle
    %they are actually all percentages
    %TDN is total digestible nutrients, basically a value for energy
    %CP is crude protein, just what it sounds like
    %CF is crude fiber, also just what it sounds like
    %EE is ether extract, another way of saying crude fat content
    %Ash basically just quantifies the total mineral content, this is
    %probably the least useful of all the values because the user
    %is probably more interested in specific minerals rather than all
    %minerals
    
    wCornTDN = 88;
    wCornCP = 9;
    wCornCF = 2;
    wCornEE = 4.2;
    wCornAsh = 2;

    rCornTDN = 88;
    rCornCP = 9;
    rCornCF = 2;
    rCornEE = 4.2;
    rCornAsh = 2;    

    DDGTDN = 95;
    DDGCP = 30;
    DDGCF = 8;
    DDGEE = 9.5;
    DDGAsh = 4;  

    oatsTDN = 76;
    oatsCP = 13;
    oatsCF = 11;
    oatsEE = 5;
    oatsAsh = 4;   

    molassesTDN = 74;
    molassesCP = 6;
    molassesCF = 0;
    molassesEE = 0.5;
    molassesAsh = 14;   

    soyHullTDN = 74;
    soyHullCP = 12;
    soyHullCF = 40;
    soyHullEE = 1.7;
    soyHullAsh = 5;   

    soyMealTDN = 84;
    soyMealCP = 49;
    soyMealCF = 7;
    soyMealEE = 1.5;
    soyMealAsh = 7;  

    sunflowerTDN = 64;
    sunflowerCP = 39;
    sunflowerCF = 20;
    sunflowerEE = 2.0;
    sunflowerAsh = 7; 
    
    %all of the following variables are simply weighted sums, they tell
    %what the overall nutritional facts of the entire feed mix are based on
    %the nutritional facts of each ingredient
    %keep in mind, all of these calculations won't take place until the
    %calculate button is clicked on
        totalTDN = ((wCornTDN*gui.percWholeCorn) + (rCornTDN*gui.percRolledCorn) + (DDGTDN*gui.percDDG) + (oatsTDN*gui.percOats) + (molassesTDN*gui.percMolasses)+...
            (soyHullTDN*gui.percSoyHulls) + (soyMealTDN*gui.percSoyMeal) + (sunflowerTDN*gui.percSunflower))/str2double(gui.runningTotal.String);
        
        totalCP = ((wCornCP*gui.percWholeCorn) + (rCornCP*gui.percRolledCorn) + (DDGCP*gui.percDDG) + (oatsCP*gui.percOats) + (molassesCP*gui.percMolasses)+...
            (soyHullCP*gui.percSoyHulls) + (soyMealCP*gui.percSoyMeal) + (sunflowerCP*gui.percSunflower))/str2double(gui.runningTotal.String);

        totalCF = ((wCornCF*gui.percWholeCorn) + (rCornCF*gui.percRolledCorn) + (DDGCF*gui.percDDG) + (oatsCF*gui.percOats) + (molassesCF*gui.percMolasses)+...
            (soyHullCF*gui.percSoyHulls) + (soyMealCF*gui.percSoyMeal) + (sunflowerCF*gui.percSunflower))/str2double(gui.runningTotal.String);

        totalEE = ((wCornEE*gui.percWholeCorn) + (rCornEE*gui.percRolledCorn) + (DDGEE*gui.percDDG) + (oatsEE*gui.percOats) + (molassesEE*gui.percMolasses)+...
            (soyHullEE*gui.percSoyHulls) + (soyMealEE*gui.percSoyMeal) + (sunflowerEE*gui.percSunflower))/str2double(gui.runningTotal.String);

        totalAsh = ((wCornAsh*gui.percWholeCorn) + (rCornAsh*gui.percRolledCorn) + (DDGAsh*gui.percDDG) + (oatsAsh*gui.percOats) + (molassesAsh*gui.percMolasses)+...
            (soyHullAsh*gui.percSoyHulls) + (soyMealAsh*gui.percSoyMeal) + (sunflowerAsh*gui.percSunflower))/str2double(gui.runningTotal.String);
        
        %this updates our global variables, so now we are actually
        %displaying all the nutritional facts
        gui.TDN.String = totalTDN;
        gui.CP.String = totalCP;
        gui.CF.String = totalCF;
        gui.EE.String = totalEE;
        gui.Ash.String = totalAsh; 

    end

end