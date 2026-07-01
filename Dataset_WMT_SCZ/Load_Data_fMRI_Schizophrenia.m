% Load_Data_fMRI_Schizophrenia
% addpath( genpath( 'F:\DATA\Util\Programs_for_Data_Treate\spm12' ) );
addpath( 'F:\DATA\Util\Programs_for_Data_Treate\spm12' );
addpath( pwd )
clear; close all; clc



% =========================================================================
% Make folder and copy data for preprocessing
% -------------------------------------------------------------------------





% dlist = dir( 'sub-*' );
% 
% for dn = 1 : size( dlist, 1 )
% 
%     dname = dlist( dn, 1 ).name;
% 
%     cd( dname )
% 
% 
%     cdname = pwd;
% 
% 
%     try
%         rmdir( 'preproc', 's' )
%     catch
%     end
% 
%     mkdir( 'preproc' )
% 
% 
%     cd( 'anat' )
%     flist = dir( [ dname, '_*.*' ] );
%     for fn = 1 : size( flist, 1 )
%         fname = flist( fn, 1 ).name;
%         copyfile( fname, [ cdname, '\preproc' ] )
%         clear fname
%     end; clear fn
%     cd( '..' )
% 
% 
%     cd( 'func' )
%     flist = dir( [ dname, '_*.*' ] );
%     for fn = 1 : size( flist, 1 )
%         fname = flist( fn, 1 ).name;
%         copyfile( fname, [ cdname, '\preproc' ] )
%         clear fname
%     end; clear fn
%     cd( '..' )
% 
% 
%     cd( '..' )
% 
%     
%     clear dname cdname flist
% 
%     disp( [ num2str( dn ), ' / ', num2str( size( dlist, 1 ) ) ] )
% 
% end; clear dn





% =========================================================================
% Discard, first 10 volumes
% -------------------------------------------------------------------------





% dlist = dir( 'sub-*' );
% 
% for dn = 1 : size( dlist, 1 )
% 
%     dname = dlist( dn, 1 ).name;
% 
%     cd( dname )
% 
%     cd( 'preproc' )
% 
%     flist = dir( [ dname, '_*_bold.nii.gz' ] );
%     for fn = 1 : size( flist, 1 )
%         fname = flist( fn, 1 ).name;
%         info = niftiinfo( fname );
%         V = niftiread( info );
%         V = V( :, :, :, 11 : end );% Discard, first 10 volumes
%         info.ImageSize( 4 ) = info.ImageSize( 4 ) - 10;
%         info.raw.dim( 5 ) = info.raw.dim( 5 ) - 10;
%         niftiwrite( V, fname( 1 : end - 3 ), info );
%         delete( fname )
%         clear fname info V
%     end; clear fn
% 
%     flist = dir( [ dname, '_T1w.nii.gz' ] );
%     fname = flist( 1, 1 ).name;
%     info = niftiinfo( fname );
%     V = niftiread( info );
%     niftiwrite( V, fname( 1 : end - 3 ), info );
%     delete( fname )
%     clear fname info V
% 
%     cd( '..' )
%     cd( '..' )
% 
%     clear dname flist
% 
%     disp( [ num2str( dn ), ' / ', num2str( size( dlist, 1 ) ) ] )
% 
% end; clear dn





% % =========================================================================
% % Reorientation
% % -------------------------------------------------------------------------
% 
% 
% 
% 
% 
% % spm;





% =========================================================================
% Preprocessing
% -------------------------------------------------------------------------





% numSlice          = 36;
% TR                = 2.5;% second
% TA                = TR - ( TR / numSlice );
% if mod(numSlice,2) == 1
%     sliceorder     = [ 1 : 2 : numSlice, 2 : 2 : numSlice ];
%     refslice       = 1;
% else
%     sliceorder     = [ 2 : 2 : numSlice, 1 : 2 : numSlice ];
%     refslice       = 2;
% end
% voxelSize         = [ 4, 4, 4 ];
% numRun            = 3;
% 
% 
% 
% 
% 
% dlist = dir( 'sub-*' );
% 
% for sub = 1 : size( dlist, 1 )
% 
%     sub_dir = [ pwd, '/', dlist( sub, 1 ).name, '/preproc/' ];
%     disp(sub_dir);
% 
% 
% 
% 
% 
%     %%%%% Step 1: Realignment
%     %%%%% Input files: [ run1.nii  run2.nii]
%     %%%%% output files:
%     %%%%% 1) text files for the result realignment [ rp_run1.txt rp_run2.txt ]
%     %%%%% 2) mat files [ arun1.mat arun2.mat ]
%     %%%%% 3) realigned nifti files [ rrun1.nii rrun2.nii ] (updated!)
%     %%%%% 4) mean files [ meanrun1.nii meanrun2.nii ]
%     fprintf('Step 1: Realignment performing....\n');
%     for run = 1 : numRun
%         nii_file       = dir(fullfile( sub_dir, [ dlist( sub, 1 ).name, '_task-letter', num2str(run-1,'%d'), 'backtask_bold.nii' ] ));
%         nii_file       = nii_file.name;
%         volumeInfo     = spm_vol(fullfile(sub_dir,nii_file));
%         numVolume      = length(volumeInfo);
%         fprintf('Input file: % 50s\n', nii_file);
% 
%         clear matlabbatch;
%         clear filesToRealign;
%         for vol = 1:numVolume
%             filesToRealign{1}{vol}  = fullfile(sub_dir, [nii_file ',' num2str(vol)]);
%         end
%         filesToRealign{1}    = filesToRealign{1}';
%         matlabbatch{1}.spm.spatial.realign.estwrite.data = filesToRealign;
%         matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
%         matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
%         matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
%         matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 0;
%         matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
%         matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
%         matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '';
%         matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
%         matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;
%         matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
%         matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
%         matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
% 
%         spm('defaults','fmri');
%         spm_jobman('initcfg');
%         spm_jobman('run',matlabbatch);
%     end
% 
% 
% 
% 
% 
%     %%%%% Step 2: Slice Time
%     %%%%% Input files:  [  rrun1.nii  rrun2.nii ]
%     %%%%% ouptut files: [ arrun1.nii arrun2.nii ] (prefix: 'a')
%     fprintf('Step 2: Slice Time performing....\n');
%     filesToSliceTime  = cell(numRun,1);
%     for run = 1 : numRun
%         nii_file       = dir( fullfile( sub_dir, [ 'r', dlist( sub, 1 ).name, '_task-letter', num2str(run-1,'%d'), 'backtask_bold.nii' ] ) );
%         nii_file       = nii_file.name;
%         volumeInfo     = spm_vol(fullfile(sub_dir,nii_file));
%         numVolume      = length(volumeInfo);
% 
%         fprintf('Input file: %50s\n', nii_file);
%         for vol = 1:numVolume
%             filesToSliceTime{run}{vol}    = fullfile(sub_dir,[nii_file ',' num2str(vol)]);
%         end
%         filesToSliceTime{run} = filesToSliceTime{run}';
%     end
% 
%     clear matlabbatch;
%     spm('defaults','fmri');
%     spm_jobman('initcfg');
%     matlabbatch{1}.spm.temporal.st.scans      = filesToSliceTime;
%     matlabbatch{1}.spm.temporal.st.nslices    = numSlice;
%     matlabbatch{1}.spm.temporal.st.tr         = TR;
%     matlabbatch{1}.spm.temporal.st.ta         = TA;
%     matlabbatch{1}.spm.temporal.st.so         = sliceorder;
%     matlabbatch{1}.spm.temporal.st.refslice   = refslice;
%     matlabbatch{1}.spm.temporal.st.prefix     = 'a';
%     spm_jobman('run',matlabbatch);
% 
% 
% 
% 
% 
%     %%%%% Step 3: Coregistration
%     %%%%% Input files : [ meanarun1.nii meanarun2.nii] + t1.nii
%     %%%%%    Prior to this procecess, t1.nii must be copyed -> [run1t1.nii run2t1.nii]
%     %%%%%    Because t1.nii will be modified after coregistration
%     %%%%% Output: no new files but modified run1t1.nii run2t1.nii
% 
%     fprintf('Step 3: Coregistration performing....\n');
%     anat_file      = dir( [ sub_dir, dlist( sub, 1 ).name, '_T1w.nii' ] );
%     anat_name      = anat_file.name;
%     anat_name      = fullfile(sub_dir,anat_name);
% 
%     for run = 1 : numRun
%         anat_run_file  = ['run' num2str(run-1,'%d') anat_file.name];
%         anat_run_name  = fullfile(sub_dir,anat_run_file);
%         fprintf('copying...\n');
%         fprintf('source: %40s\n', anat_name);
%         fprintf('destination: %40s\n', anat_run_name);
%         copyfile(anat_name,anat_run_name);
% 
%         mean_nii_file  = dir(fullfile(sub_dir,['mean' dlist( sub, 1 ).name, '_task-letter', num2str(run-1,'%d'), 'backtask_bold.nii']));
%         mean_nii_file  = mean_nii_file.name;
%         mean_nii_file  = fullfile(sub_dir,mean_nii_file);
% 
%         clear matlabbatch;
%         spm('defaults','fmri');
%         spm_jobman('initcfg');
%         matlabbatch{1}.spm.spatial.coreg.estimate.ref   = {mean_nii_file};
%         matlabbatch{1}.spm.spatial.coreg.estimate.source = {anat_run_name};
%         matlabbatch{1}.spm.spatial.coreg.estimate.other = {''};
%         matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
%         matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
%         matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
%         matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
%         spm_jobman('run',matlabbatch);
%     end
% 
% 
% 
% 
% 
%     %%%%% Step 4: Segmentation
%     %%%---------------------------------------------------------------------
%     %%% Segment produces 5 new images:
%     %%% c1* - grey matter
%     %%% c2* - white matter
%     %%% c3* - CSF, bone
%     %%% c4* - soft tissue
%     %%% c5* - air/background
%     %%%---------------------------------------------------------------------
%     %%%%% Input files : [ run1t1.nii run2t1.nii ] + [ arun1.nii arun2.nii ]
%     %%%%% Output:
%     %%%%% 1) [     run1t1_seg8.mat     run2t1_seg8.mat ]
%     %%%%% 2) [  c[12345]run1t1.nii  c[12345]run2t1.nii ]
%     %%%%% 3) [ rc[12345]run1t1.nii rc[12345]run2t1.nii ]
% 
%     fprintf('Step 4: Segmentation....\n');
%     for run = 1 : numRun
%         anat_file      = dir( [sub_dir, 'run', num2str(run-1,'%d'), dlist( sub, 1 ).name, '_T1w.nii' ] );
%         anat_name      = anat_file.name;
%         anat_file      = fullfile(sub_dir,anat_name);
%         disp(anat_file);
% 
%         clear matlabbatch;
%         spm('defaults','fmri');
%         spm_jobman('initcfg');
%         matlabbatch{1}.spm.spatial.preproc.channel.vols = {anat_file};
%         matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
%         matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
%         matlabbatch{1}.spm.spatial.preproc.channel.write = [0 1];
%         matlabbatch{1}.spm.spatial.preproc.tissue(1).tpm = {'F:\DATA\Util\Programs_for_Data_Treate\spm12\tpm\TPM.nii,1'};
%         matlabbatch{1}.spm.spatial.preproc.tissue(1).ngaus = 1;
%         matlabbatch{1}.spm.spatial.preproc.tissue(1).native = [1 0];
%         matlabbatch{1}.spm.spatial.preproc.tissue(1).warped = [0 0];
%         matlabbatch{1}.spm.spatial.preproc.tissue(2).tpm = {'F:\DATA\Util\Programs_for_Data_Treate\spm12\tpm\TPM.nii,2'};
%         matlabbatch{1}.spm.spatial.preproc.tissue(2).ngaus = 1;
%         matlabbatch{1}.spm.spatial.preproc.tissue(2).native = [1 0];
%         matlabbatch{1}.spm.spatial.preproc.tissue(2).warped = [0 0];
%         matlabbatch{1}.spm.spatial.preproc.tissue(3).tpm = {'F:\DATA\Util\Programs_for_Data_Treate\spm12\tpm\TPM.nii,3'};
%         matlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus = 2;
%         matlabbatch{1}.spm.spatial.preproc.tissue(3).native = [1 0];
%         matlabbatch{1}.spm.spatial.preproc.tissue(3).warped = [0 0];
%         matlabbatch{1}.spm.spatial.preproc.tissue(4).tpm = {'F:\DATA\Util\Programs_for_Data_Treate\spm12\tpm\TPM.nii,4'};
%         matlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus = 3;
%         matlabbatch{1}.spm.spatial.preproc.tissue(4).native = [1 0];
%         matlabbatch{1}.spm.spatial.preproc.tissue(4).warped = [0 0];
%         matlabbatch{1}.spm.spatial.preproc.tissue(5).tpm = {'F:\DATA\Util\Programs_for_Data_Treate\spm12\tpm\TPM.nii,5'};
%         matlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus = 4;
%         matlabbatch{1}.spm.spatial.preproc.tissue(5).native = [1 0];
%         matlabbatch{1}.spm.spatial.preproc.tissue(5).warped = [0 0];
%         matlabbatch{1}.spm.spatial.preproc.tissue(6).tpm = {'F:\DATA\Util\Programs_for_Data_Treate\spm12\tpm\TPM.nii,6'};
%         matlabbatch{1}.spm.spatial.preproc.tissue(6).ngaus = 2;
%         matlabbatch{1}.spm.spatial.preproc.tissue(6).native = [0 0];
%         matlabbatch{1}.spm.spatial.preproc.tissue(6).warped = [0 0];
%         matlabbatch{1}.spm.spatial.preproc.warp.mrf = 1;
%         matlabbatch{1}.spm.spatial.preproc.warp.cleanup = 1;
%         matlabbatch{1}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
%         matlabbatch{1}.spm.spatial.preproc.warp.affreg = 'mni';
%         matlabbatch{1}.spm.spatial.preproc.warp.fwhm = 0;
%         matlabbatch{1}.spm.spatial.preproc.warp.samp = 3;
%         matlabbatch{1}.spm.spatial.preproc.warp.write = [0 1];
%         spm_jobman('run',matlabbatch);
%     end
% 
% 
% 
% 
% 
%     %%%%% Step 5: Normalization
%     %%%%% Input files : [ run1t1.nii run2t1.nii ] + [ arun1.nii arun2.nii ]
%     %%%%% Output:
%     %%%%% 1) [        y_run1t1.nii        y_run2t1.nii ]
%     %%%%% 2) [          warun1.nii          warun2.nii ]
%     %%%%% 3) [ wc[12345]run1t1.nii wc[12345]run2t1.nii ]
%     for run = 1 : numRun
%         anat_file      = dir( [sub_dir, 'y_run', num2str(run-1,'%d'), dlist( sub, 1 ).name, '_T1w.nii' ] );
%         anat_name      = anat_file.name;
%         anat_file      = fullfile(sub_dir,anat_name);
%         disp(anat_file);
% 
%         nii_file       = dir(fullfile(sub_dir, [ 'ar', dlist( sub, 1 ).name, '_task-letter', num2str(run-1,'%d'), 'backtask_bold.nii' ]));
%         nii_name       = nii_file.name;
%         nii_file       = fullfile(sub_dir,nii_name);
%         disp(nii_file);
% 
%         volumeInfo  = spm_vol(nii_file);
%         numVolume   = length(volumeInfo);
%         clear matlabbatch;
%         spm('defaults','fmri');
%         spm_jobman('initcfg');
%         matlabbatch{1}.spm.spatial.normalise.write.subj.def = {anat_file};
%         matlabbatch{1}.spm.spatial.normalise.write.subj.resample = {nii_file};
%         matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70; 78 76 85];
%         matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = voxelSize;
%         matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
%         matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = 'w';
%         spm_jobman('run',matlabbatch);
%     end
%     for run = 1 : numRun
%         anat_file      = dir( [sub_dir, 'y_run', num2str(run-1,'%d'), dlist( sub, 1 ).name, '_T1w.nii' ] );
%         anat_name      = anat_file.name;
%         anat_file      = fullfile(sub_dir,anat_name);
%         disp(anat_file);
% 
%         nii_file       = dir( [sub_dir, 'c1run', num2str(run-1,'%d'), dlist( sub, 1 ).name, '_T1w.nii' ] );
%         nii_name       = nii_file.name;
%         nii_file       = fullfile(sub_dir,nii_name);
%         disp(nii_file);
% 
%         volumeInfo  = spm_vol(nii_file);
%         numVolume   = length(volumeInfo);
%         clear matlabbatch;
%         spm('defaults','fmri');
%         spm_jobman('initcfg');
%         matlabbatch{1}.spm.spatial.normalise.write.subj.def = {anat_file};
%         matlabbatch{1}.spm.spatial.normalise.write.subj.resample = {nii_file};
%         matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70; 78 76 85];
%         matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = voxelSize;
%         matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
%         matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = 'w';
%         spm_jobman('run',matlabbatch);
%     end
%     for run = 1 : numRun
%         anat_file      = dir( [sub_dir, 'y_run', num2str(run-1,'%d'), dlist( sub, 1 ).name, '_T1w.nii' ] );
%         anat_name      = anat_file.name;
%         anat_file      = fullfile(sub_dir,anat_name);
%         disp(anat_file);
% 
%         nii_file       = dir( [sub_dir, 'c2run', num2str(run-1,'%d'), dlist( sub, 1 ).name, '_T1w.nii' ] );
%         nii_name       = nii_file.name;
%         nii_file       = fullfile(sub_dir,nii_name);
%         disp(nii_file);
% 
%         volumeInfo  = spm_vol(nii_file);
%         numVolume   = length(volumeInfo);
%         clear matlabbatch;
%         spm('defaults','fmri');
%         spm_jobman('initcfg');
%         matlabbatch{1}.spm.spatial.normalise.write.subj.def = {anat_file};
%         matlabbatch{1}.spm.spatial.normalise.write.subj.resample = {nii_file};
%         matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70; 78 76 85];
%         matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = voxelSize;
%         matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
%         matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = 'w';
%         spm_jobman('run',matlabbatch);
%     end
% 
% 
% 
% 
% 
%     %%%%% Step 6: Smoothing
%     %%%%% Input files : [  warrun1.nii  warrun2.nii ]
%     %%%%% Output files: [ swarrun1.nii swarrun2.nii ]
%     for run = 1 : numRun
%         nii_file       = dir(fullfile(sub_dir, [ 'war', dlist( sub, 1 ).name, '_task-letter', num2str(run-1,'%d'), 'backtask_bold.nii' ]));
%         nii_name       = nii_file.name;
%         nii_file       = fullfile(sub_dir,nii_name);
% 
%         volumeInfo     = spm_vol(fullfile(nii_file));
%         numVolume      = length(volumeInfo);
%         fprintf('Input file: % 50s\n', nii_file);
% 
%         clear matlabbatch;
%         clear filesToSmooth;
%         spm('defaults','fmri');
%         spm_jobman('initcfg');
%         for vol = 1:numVolume
%             filesToSmooth{vol}  = fullfile([nii_file ',' num2str(vol)]);
%         end
%         matlabbatch{1}.spm.spatial.smooth.data = filesToSmooth';
%         matlabbatch{1}.spm.spatial.smooth.fwhm = [6 6 6];
%         matlabbatch{1}.spm.spatial.smooth.dtype = 0;
%         matlabbatch{1}.spm.spatial.smooth.im = 0;
%         matlabbatch{1}.spm.spatial.smooth.prefix = 's';
%         spm_jobman('run',matlabbatch);
%     end
% 
% 
% 
% 
% 
% end





% =========================================================================
% Copy only "good" preprocessed data
% -------------------------------------------------------------------------





% cdname = pwd;
% addpath( genpath( cdname ) );
% 
% voxelSize         = [ 4, 4, 4 ];
% numRun            = 3;
% 
% mkdir( 'MatGW' )
% 
% 
% dlist = dir( 'sub-*' );
% 
% for dn = 1 : size( dlist, 1 )
% 
%     dname = dlist( dn ).name;
% 
%     cd( dname )
% 
%     cd( 'preproc' )
% 
%     % ---------------------------------------------------------------------
% 
%     move_voxel = [];
%     for run = 1 : numRun
%         fname = dir( [ 'rp_', dlist( dn, 1 ).name, '_task-letter', num2str(run-1,'%d'), 'backtask_bold.txt' ] );
%         dv = importdata( fname( 1, 1 ).name );
%         dv = dv( :, 1 : 3 );
%         move_voxel( run, 1 ) = max( abs( dv( : ) ) ) > min( voxelSize );
%         clear dv
%     end; clear run
% 
%     % ---------------------------------------------------------------------
% 
%     bold = cell( numRun, 1 );
%     events = cell( numRun, 1 );
%     c1 = cell( numRun, 1 );
%     c2 = cell( numRun, 1 );
%     for run = 1 : numRun
% 
%         fname = dir( [ dname, '_task-letter', num2str(run-1,'%d'), 'backtask_events.tsv' ] );
%         [ ~, ~, event_raw ] = tsvread( fname( 1, 1 ).name );
%         events{ run, 1 } = event_raw;
%         % events{ run, 1 } = importdata( fname( 1, 1 ).name );
%         
%         % fname = dir( [ 'swar', dlist( dn, 1 ).name, '_task-letter', num2str(run-1,'%d'), 'backtask_bold.nii' ] );
%         fname = dir( [ 'war', dlist( dn, 1 ).name, '_task-letter', num2str(run-1,'%d'), 'backtask_bold.nii' ] );
%         bold{ run, 1 } = niftiread( fname( 1, 1 ).name );
% 
%         dim_data = size( bold{ run, 1 }, 1 : 3 );
%         fname = dir( [ 'wc1run', num2str( run-1 ), dlist( dn, 1 ).name, '_T1w.nii' ] );
%         c_data = niftiread( fname( 1, 1 ).name );
%         % c_data( c_data < 255 / 2 ) = 0;
%         c_data( c_data < 255 / 128 ) = 0;
%         c_data( c_data > 0 ) = 1;
%         c_data = logical( c_data );
%         c1{ run, 1 } = c_data;
%         fname = dir( [ 'wc2run', num2str( run-1 ), dlist( dn, 1 ).name, '_T1w.nii' ] );
%         c_data = niftiread( fname( 1, 1 ).name );
%         % c_data( c_data < 255 / 2 ) = 0;
%         c_data( c_data < 255 / 128 ) = 0;
%         c_data( c_data > 0 ) = 1;
%         c_data = logical( c_data );
%         c2{ run, 1 } = c_data;
%         clear dim_data c_data
%     end; clear run
% 
%     % ---------------------------------------------------------------------
% 
%     cd( '..' )
% 
%     cd( '..' )
% 
%     if sum( move_voxel ) == 0
% 
%         cd( 'MatGW' )
%         for run = 1 : numRun
%             V = bold{ run, 1 };
%             V = single( V );
%             idxV = c1{ run, 1 } | c2{ run, 1 };
%             for t = 1 : size( V, 4 )
%                 tV = V( :, :, :, t );
%                 tV( idxV ~= 1 ) = nan;
%                 V( :, :, :, t ) = tV;
%             end; clear t tV
%             niftiwrite( V, [ 'preproc_GW_', dname, '_', num2str( run ), '_bold' ], 'Compressed', true )
%             clear V idxV
% 
%             event = events{ run, 1 };
%             save( [ 'preproc_GW_', dname, '_', num2str( run ), '_event.mat' ], 'event' )
%             clear event
%         end; clear run
%         cd( '..' )
% 
%     end
%     clear move_voxel bold events c1 c2
% 
%     disp( [ dname ] )
%     clear dname
% 
% end; clear dn
% 
% clear dlist





% % Missing participants ====================================================
% 
% dlist = dir( 'sub-*' );
% 
% cd( 'MatGW' )
% 
% missingParticipant = [];
% for p = 1 : size( dlist, 1 )
%     flist = dir( [ 'preproc_GW_', dlist( p, 1 ).name, '_1_bold.nii.gz' ] );
%     if size( flist, 1 ) == 0
%         missingParticipant( p, 1 ) = 1;
%     elseif size( flist, 1 ) == 1
%         missingParticipant( p, 1 ) = 0;
%     end
%     clear flist
% end; clear p
% 
% cd( '..' )
% 
% save( 'missingParticipant.mat', 'missingParticipant' )

