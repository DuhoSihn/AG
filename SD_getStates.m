function states = SD_getStates( data, edges )
% get standardized states based on edges
% 
% data: amplitude envelope, ( channel ) X ( time ) matrix.
% edges: parameter to convert data to standardized states, the output of "SD_getEdges.m".
%
% states: standardized states, ( channel ) X ( time ) matrix.

[ N_ch, L_data ] = size( data );
[ ~, L_edges ] = size( edges );

states = nan( N_ch, L_data );
for ch = 1 : N_ch
    for s = 1 : L_edges - 1
        if s == 1
            idx = data( ch, : ) < edges( ch, s + 1 );
        elseif s == L_edges - 1
            idx = data( ch, : ) >= edges( ch, s );
        else
            idx = data( ch, : ) >= edges( ch, s ) & data( ch, : ) < edges( ch, s + 1 );
        end
        states( ch, idx ) = s;
    end
end
