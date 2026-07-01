% Load_Data_RD_PBW
addpath( genpath( 'F:\DATA\Util\Programs_for_Data_Treate\eeglab2023.0' ) );
clear; close; clc


eeglab;


dlist = dir( 'sub-???' );

for dn = 1 : size( dlist, 1 )
    
    dname = dlist( dn ).name;
    
    cd( dname )

    dlist2 = dir( 'ses-??' );

    for dn2 = 1 : size( dlist2, 1 )

        dname2 = dlist2( dn2 ).name;

        cd( dname2 )

        cd( 'eeg' )

        flist = dir( '*.set' );

        for fn = 1 : size( flist, 1 )

            fname = flist( fn ).name;

            raw = pop_loadset( fname );

            clear fname

            cd( '..' )
            cd( '..' )
            cd( '..' )

            save( [ 'raw_', dname, '_', dname2, '_', num2str( fn ), '.mat' ], 'raw' )

            clear raw

            cd( dname )

            cd( dname2 )

            cd( 'eeg' )

        end; clear fn

        cd( '..' )
        cd( '..' )

        clear dname2

    end; clear dn2

    cd( '..' )
    
    clear dname dlist2
    
end; clear dn

clear dlist


close;

