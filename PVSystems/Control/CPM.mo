within PVSystems.Control;
model CPM "Current Programmed Mode controller for averaged models"
  extends Interfaces.CPMInterface;
protected
  Real d2;
equation
  d2 = min(L*fs*(vc - Va*d)/Rf/vm2, 1 - d);
  d = 2*(vc*(d + d2) - vs)/(vm1 + vm2)*d2*(d + d2) + 2*Va*(d + d2);
end CPM;
