df = readtable('test_data.csv','NumHeaderLines', 1);
X = df(:, 1:25);
X = table2array(X)';
y = df(:, 26:29);
y = table2array(y)';

y_pred = myNeuralNetworkFunction2(X);
e = gsubtract(y,y_pred);

