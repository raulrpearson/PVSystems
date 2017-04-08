within PVSystems.Control;
model CPM_CCM "Current Programmed Mode controller for averaged CCM models"
  extends Interfaces.CPMInterface;
equation
  d = 2*(vc - vs)/(Rf/L/fs*(vm1 + vm2)*(1 - d) + 2*Va);
end CPM_CCM;
