%
%########################################################################
%#  plot passive scalar
%########################################################################
%
figure(1);clf;

name = '/scratch2/taylorm/tmix256C/tmix256C-gradxy2'
time=1.05;
times=sprintf('%.5f',time+10000);
times=times(2:length(times)-1);

schmidt_list=[.01 .05 .1 .5 1];
type_list=0:1;
npassive=length(schmidt_list)*length(type_list);

k=0;
for sch=schmidt_list
for type=type_list

  ext=sprintf('%3i',type+100);
  ext=ext(2:length(ext));
  ext2=sprintf('%8.3f',sch+1000);
  ext2=ext2(2:length(ext2));

  ext=['.t',ext,'.s',ext2];
  
  s=findstr(name,'/');
  s=s(length(s));
  shortname=name(s+1:length(name));

   fname=[name,times,ext]
   [x,y,z,s,time]=getfield(fname);
   smax=max(max(s));
   [mx,slice1]=max(smax);
   smax=min(min(s));
   [mn,slice2]=min(smax);

   k=k+1;
   splot=squeeze(s(:,:,slice1));

   figure(2)
   subplot(npassive/2,2,k)
   pcolor(x,y,log(splot'));  caxis([log(.01) log(13)]) ;
   axis equal
   axis([0,max(x),0,max(y)]);
   shading interp

   figure(1)
   subplot(npassive/2,2,k)
   pcolor(x,y,splot');   caxis([0 13]) ;
   axis equal
   axis([0,max(x),0,max(y)]);
   shading interp

   stitle=sprintf('time=%.2f  min=%f  max=%f',time,mn,mx)
   if (k==1) title(stitle); end;
end
end
figure(1)
orient tall
print('-djpeg','-r125',['pdiss',times,'.jpg']); 
figure(2)
orient tall
print('-djpeg','-r125',['plogdiss',times,'.jpg']); 

