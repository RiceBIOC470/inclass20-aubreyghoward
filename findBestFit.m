function [BestFit] = findBestFit (xx,yy,fit_model)

BestFit.Metrics.adjrsquare = 0;
for i = 1:10 
    for ii = 1:10
    [fit_out, fit_metric] = fit(xx',yy',fit_model,'StartPoint',[i,ii]);
        if (fit_metric.adjrsquare) > BestFit.Metrics.adjrsquare
            tempMetrics(1) = fit_metric.adjrsquare;%used in troubleshooting
            BestFit.Metrics = fit_metric;
            BestFit.fit_out = fit_out;
            BestFit.StartPoint = [i,ii];
            Stpt = [i,ii];
        end
    end
    
end

if Stpt(1,1) < range(xx) && Stpt(1,2) < range(xx)
for i = Stpt(1,1):10 %Finds the optimal Upper bound.
    for ii = Stpt(1,2):10
    [fit_out, fit_metric] = fit(xx',yy',fit_model,'StartPoint',Stpt,'Upper',[i,ii]);
        if (fit_metric.adjrsquare) > BestFit.Metrics.adjrsquare
            tempMetrics(2) = fit_metric.adjrsquare;%used in troubleshooting
            BestFit.Metrics = fit_metric;
            BestFit.fit_out = fit_out;
            BestFit.UpperBound = [i,ii];
            upbnd = [i,ii];
        else
            upbnd = Stpt;
        end
    end
    
end
else
    upbnd = Stpt;
    disp('Upper Bound approached by Starting point')
end


if Stpt(1,1)< upbnd(1,1) && Stpt(1,2) < upbnd(1,2)
i = 0;
ii = 0;
for i = Stpt(1,1):upbnd(1,1) %Finds the optimal Lower bound.
    for ii = Stpt(1,2):upbnd(1,2)
    [fit_out, fit_metric] = fit(xx',yy',fit_model,'StartPoint',Stpt,'Lower',[i,ii],'Upper',upbnd);
        if (fit_metric.adjrsquare) > BestFit.Metrics.adjrsquare
            tempMetrics(3) = fit_metric.adjrsquare; %used in troubleshooting
            BestFit.Metrics = fit_metric;
            BestFit.fit_out = fit_out;
            BestFit.LowerBound = [i,ii];
            lowbnd = [i,ii];
        else
            lowbnd = Stpt;
        end
    end
end   
    
else
    lowbnd = Stpt;
    disp('lower bound approached by start point');
end

end %End Function