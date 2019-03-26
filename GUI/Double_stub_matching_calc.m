load_impedance = 120 - j20;
d = 

load_admittance = 1/load_impedance;
characteristic_impedance = 50;
characteristic_admittance = 1/characteristic_impedance;

syms beta t z_in
t = tan(beta*d);
lambda_in = characteristic_admittance((load_admittance+1j*characteristic_admittance*t)/(characteristic_admittance+1j*load_admittance*t));
z_in = 1/lambda_in ;

