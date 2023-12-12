//
//  ViewController.m
//  DiazNayely-R3-U2
//
//  Created by Ismael Sánchez Rios on 11/12/23.
//

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Configurar la imagen de bienvenida al usuario
    UIImage *welcomeImage = [UIImage imageNamed:@"pantallabienvenida"];
    self.welcomeImageView = [[UIImageView alloc] initWithImage:welcomeImage];
    self.welcomeImageView.contentMode = UIViewContentModeScaleAspectFill; // Ajustar el modo de contenido según sea necesario
    self.welcomeImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.welcomeImageView];
    
    // Configurar el botón de comenzar
    self.startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.startButton setTitle:@"Comenzar" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(startButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.startButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.startButton];
    
    // Configurar autolayout para posicionar elementos
    [NSLayoutConstraint activateConstraints:@[
        // Imagen de bienvenida ocupa toda la pantalla
        [self.welcomeImageView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.welcomeImageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.welcomeImageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.welcomeImageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        
        // Botón en la parte inferior
        [self.startButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.startButton.widthAnchor constraintEqualToConstant:120.0], // Ajustar el ancho según sea necesario
        [self.startButton.heightAnchor constraintEqualToConstant:40.0], // Ajustar el alto según sea necesario
        [self.startButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-40.0],
    ]];
}

- (void)startButtonTapped:(UIButton *)sender {
    // Acción al presionar el botón "Comenzar"
    
    // Crear e iniciar la instancia del segundo controlador de vista (ViewController2)
    ViewController2 *secondViewController = [[ViewController2 alloc] initWithNibName:@"ViewController2" bundle:nil];
    
    // Presentar el segundo controlador de vista
    [self presentViewController:secondViewController animated:YES completion:nil];
}




@end
