% Imágenes híbridas

close all; clear all% closes all figures

%% Setup
% read images and convert to floating point format
Im1 = im2single(imresize(imread('acostados.jpg'),0.1));
%Im1=imresize(Im1, 0.1);
figure,imshow(Im1)
Im2 = im2single(imresize(imread('parados.jpg'),0.1));
%Im2=imresize(Im2, 0.1);
figure,imshow(Im2)

%% Filtering and Hybrid Image construction
cutoff_frequency = 10; 
%creación del filtro gaussiano
filter = fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);
A = imfilter(Im1,filter);
figure,imshow(A)
LF = imfilter(Im2,filter);
figure,imshow(LF)

%Construcción de una imagen de alta frecuencia 
HF=Im1-A;
figure,imshow(HF), title('alta frecuencia')

%ADICIÓN DE IMAGENES
Hibrida=HF+LF;
figure,imshow(Hibrida), title('Imagen híbrida')

%Construccón de una pirámide piramide 
I1=impyramid(Hibrida,'reduce');
I2=impyramid(I1,'reduce');
I3=impyramid(I2,'reduce');
I4=impyramid(I3,'reduce');
I5=impyramid(I4,'reduce');

figure
 subplot(1,5,1),imshow(I1)
subplot(1,5,2),imshow(I2)
subplot(1,5,3),imshow(I3)
subplot(1,5,4),imshow(I4)
subplot(1,5,5),imshow(I5)
%Escritura de la imagen del mosaico
print ('-dpng','rgb_mosaic.png');

%% Escritura de imágenes como archivos
imwrite(LF, 'low_frequencies.jpg', 'quality', 95);
imwrite(HF + 0.5, 'high_frequencies.jpg', 'quality', 95);
imwrite(Hibrida, 'hybrid_image.jpg', 'quality', 95);