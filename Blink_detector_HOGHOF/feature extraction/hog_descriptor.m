function [descriptor] = hog_descriptor(texture,options,start_frame,end_frame)

	%This is basically a croping and masking operation so it should be relative fast. No need for saving 

	% import essential dependencies
	addpath('~/Dropbox/Research/Code/HOG/code3/')

	% initialise options of hog descriptor
	n_bins     = options.n_bins;
	w_cell     = options.w_cell;
	w_block    = options.w_block;
	gamma      = options.gamma;
	sigma      = options.sigma;
	block_step = options.block_step;
	mask       = options.mask;

	% we assume that texture is a stack of black and white images
	nb_images = size(texture,3);
	for i=1:nb_images

		% pick an image from the stack
		img = texture(:,:,i);

		% calculate hog for this image
		hog_feature = standard_HoG_compute(img,mask,w_cell,gamma,sigma,n_bins,w_block,block_step);

		% save the result in a matrix where each row contains info about an image
		hog_stack(i,:) = hog_feature(:);

	end

	% collapse the information in a vector
	descriptor = hog_stack(:);


end