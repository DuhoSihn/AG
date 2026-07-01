function edges = SD_getEdges( data, nBins )
% get edges to convert data to standardized states
% 
% data: amplitude envelope, ( channel ) X ( time ) matrix.
% nBins: the number of bins, i.e., the number of standardized states
%
% edges: parameter to convert data to standardized states

[ N_ch, L_data ] = size( data );

stamps = linspace( 1, L_data, nBins + 1 );
stamps = round( stamps );

data = sort( data, 2 );

edges = nan( N_ch, nBins + 1 );
for ch = 1 : N_ch
    edges( ch, : ) = data( ch, stamps );
end
