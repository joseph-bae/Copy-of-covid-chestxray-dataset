maxslice_idx = findMaxSlice(Femalemasks{1});
featints=Femalefeatints{1};
mask=~Femalemasks{1};
featvol = nan(size(mask,1),size(mask,2),length(featints));
length(featints)
for i = 1:length(featints)
    fvol = createFeatVol(featints{i},mask);
    sl = fvol(:,:,maxslice_idx);
    featvol(:,:,i) = sl;
    
end

figure;
cmap = jet(256);
cmap(1,:) = [0 0 0];
vv(featvol,[],cmap,[0 1]); %each "slice" is a feature from img