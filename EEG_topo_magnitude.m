function h = EEG_topo_magnitude( data, elecloc, boundary, resol, NN, marker_idx, marker_size, clim, colors )
% Plot, EEG topography
%
% data : electrode values, (N) X (1) vector.
% elecloc : electrode locations, (N) X (2) maxtrix.
% boundary : boundary definition, (1) X (3) vector, [ center_x_position, center_y_position, radius ].
% resol : resolution, the number of filling bins, scalar.
% NN : the Number of Neighbors to take into account electrodes, scalar.
% marker_idx : marker index to indentify showing.
% marker_size : electrode locaton marker size.
% clim : color range, (1) X (2) vector.
% colors : the name of colormap

x_range = [ boundary( 1 ) - boundary( 3 ), boundary( 1 ) + boundary( 3 ) ];
y_range = [ boundary( 2 ) - boundary( 3 ), boundary( 2 ) + boundary( 3 ) ];

x = linspace( x_range( 1 ), x_range( 2 ), resol );
y = linspace( y_range( 1 ), y_range( 2 ), resol );
[ mx, my ] = meshgrid( x, y );

dist_elec = sqrt( bsxfun( @minus, mx, permute( elecloc( :, 1 ), [ 3, 2, 1 ] ) ) .^ 2 + bsxfun( @minus, my, permute( elecloc( :, 2 ), [ 3, 2, 1 ] ) ) .^ 2 );
sort_dist_elec = sort( dist_elec, 3 );
dist_elec( bsxfun( @gt, dist_elec, sort_dist_elec( :, :, NN ) ) ) = NaN;
dist_elec2elec = permute( sum( bsxfun( @minus, elecloc, permute( elecloc, [ 3, 2, 1 ] ) ) .^ 2, 2 ), [ 1, 3, 2 ] );
dist_elec2elec( logical( eye( size( elecloc, 1 ) ) ) ) = NaN;
dist_elec2elec = min( dist_elec2elec( : ), [], 'omitnan' );
dist_elec( dist_elec < dist_elec2elec * 10^(-3) ) = dist_elec2elec * 10^(-3);

weight_elec = 1 ./ dist_elec;
weight_elec = bsxfun( @rdivide, weight_elec, sum( weight_elec, 3, 'omitnan' ) );

data_xy = repmat( permute( data, [ 3, 2, 1 ] ), [ resol, resol, 1 ] );

topo = sum( data_xy .* weight_elec, 3, 'omitnan' );
% topo = angle( sum( exp( 1i * data_xy ) .* weight_elec, 3, 'omitnan' ) );

idx_nan = sqrt( ( mx - boundary( 1 ) ) .^ 2 + ( my - boundary( 2 ) ) .^ 2 ) > boundary( 3 );
topo( idx_nan ) = NaN;

imagesc( x, y, topo, 'alphadata', ~isnan( topo ), clim )
colormap( gca, colors )
axis xy
hold on
for elec = 1 : size( elecloc, 1 )
    if marker_idx( elec ) == 1
        plot( elecloc( elec, 1 ), elecloc( elec, 2 ), 'ok', 'markerfacecolor', 'k', 'markersize', marker_size )
    end
end; clear elec
hold off
axis image
axis off
