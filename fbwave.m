t = linspace(0,5 * 10^-9,100);
z = linspace(0, 0.4, 100);

% % % part 2 
% vf = [];
% vb = [];
% iif = []
% for i=1:100
%     for j=1:100
%         [a, b] = forward_wave(1, 2 * pi * 10^9, 0, 50, 2 * 10^8, z(i), t(j));
%         vf(i, j) = a;
%         iif(i, j) = b;
%     
%         [a, ~] = backward_wave(1, 2 * pi * 10^9, 0, 50, 2 * 10^8, z(i), t(j));
%         vb(i, j) = a;
%     end
% end
% 
% for k=1:length(t)
%     plot(z, vf(k,:),'b'); hold on;
%     plot(z, iif(k,:),'r'); hold off;
%     xlabel('z [m]');
%     ylabel('v(z,t)[V]');
%     title('instantaneous voltage on a lossless line');
%     legend('v_f(z,t)',' v_b(z,t)');
%     axis([0 0.4 -1 1]);
%     M(k)=getframe;
% end;


% part 3 
% vs = []
% cs = []
% for i=1:100
%     for j=1:100
%         [a, b] = standing_wave(1, 2 * pi * 10^9, 0, 50, 2 * 10^8, z(i), t(j));
%         vs(i, j) = a;
%         cs(i, j) = b;
%     end
% end
% 
% for k=1:length(t)
%     plot(z, vs(k,:),'b'); hold on;
%     plot(z, cs(k,:),'r'); hold off;
%     xlabel('z [m]');
%     ylabel('v(z,t)[V]/i(z, t)[A]');
%     title('instantaneous voltage/current on a lossless line');
%     legend('v_s(z,t)',' i_s(z,t)');
%     axis([0 0.4 -1 1]);
%     M(k)=getframe;
% end;

% part 4 
beta = 2 * pi / 0.20;
V = []
omega = 2 * pi * 10^9
for ii=1:100
    V(ii) = 1i * exp(-1i * beta * z(ii));
end
disp(size(V))
v = ph2inst(V, omega, t);
disp(size(v))

for k=1:length(t)
    disp(v(k, :))
    plot(z, v(k, :),'r'); hold off;
    xlabel('z [m]');
    ylabel('v(z,t)[V]');
    title('instantaneous voltage on a lossless line');
    legend('v(z,t)');
    axis([0 0.4 -1 1]);
    M(k)=getframe;
end;


function [volf, currf] = forward_wave(v0, omega, phi, z0, vp, z, t)
    volf = v0 * cos(omega * (t - z/vp) + phi);
    currf = volf/z0;
end 

function [volb, currb] = backward_wave(v0, omega, phi, z0, vp, z, t)
    volb = v0 * cos(omega * (t + z/vp) + phi);
    currb = -volb/z0;
end

function [vols, currs] = standing_wave(v0, omega, phi, z0, vp, z, t)
    [volf, currf] = forward_wave(v0, omega, phi, z0, vp, z, t);
    [volb, currb] = backward_wave(v0, omega, phi, z0, vp, z, t);
    vols = volf + volb;
    currs = currf + currb;
end


function [v] = ph2inst(V, omega, t)
    v = []
    for k=1:length(t)
        v(:, k) = real(V.*exp(j * omega * t(k)));
    end 
end 