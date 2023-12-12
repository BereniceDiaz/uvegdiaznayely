//
//  ViewController2.m
//  DiazNayely-R3-U2
//
//  Created by Ismael Sánchez Rios on 11/12/23.
//

#import "ViewController2.h"
#import "DetalleViewController.h"

@interface ViewController2 ()
@property (nonatomic, strong) NSArray *categorias;
@property (nonatomic, strong) NSString *categoriaSeleccionada;
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Configurar el logo en la parte superior
    UIImage *logoImage = [UIImage imageNamed:@"Logoapp"];
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:logoImage];
    logoImageView.contentMode = UIViewContentModeScaleAspectFit; // Ajustar el modo de contenido según sea necesario
    logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:logoImageView];
    
    // Configurar la etiqueta "Selecciona nivel de educación"
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Selecciona una categoría";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titleLabel];
    
    // Array con títulos de botones
    NSArray *buttonTitles = @[@"Miscelanea", @"Biología", @"Temas de interés"];
    
    // Color personalizado 
    UIColor *customColor = [UIColor colorWithRed:(216.0/255.0) green:(204.0/255.0) blue:(241.0/255.0) alpha:1.0];
    
    // Configurar los botones
    CGFloat buttonSpacing = 40.0; // Espaciado entre botones
    CGFloat buttonHeight = 60.0; // Altura de los botones
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = customColor; // Color de fondo personalizado
        button.layer.cornerRadius = 8.0; // Bordes redondeados
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:button];
        
        // Posicionar verticalmente los botones debajo del logo y el título
            CGFloat topPadding = 20.0; // Espaciado desde el logo y el título
            CGFloat buttonY = topPadding + CGRectGetMaxY(titleLabel.frame) + (buttonHeight + buttonSpacing) * i;
            
            // Configurar autolayout para posicionar los botones
        [NSLayoutConstraint activateConstraints:@[
            [button.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:(i + 1) * 60.0],
            [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
            [button.widthAnchor constraintEqualToConstant:200.0], // Ajustar el ancho según sea necesario
            [button.heightAnchor constraintEqualToConstant:40.0], // Ajustar el alto según sea necesario
        ]];
    }
    
    // Configurar autolayout para posicionar elementos (logo y título)
    [NSLayoutConstraint activateConstraints:@[
        // Logo centrado en la parte superior
        [logoImageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20.0],
        [logoImageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [logoImageView.widthAnchor constraintEqualToConstant:150.0], // Ajustar el ancho según sea necesario
        [logoImageView.heightAnchor constraintEqualToConstant:150.0], // Ajustar el alto según sea necesario
        
        // Etiqueta "Selecciona nivel de educación" debajo del logo
        [titleLabel.topAnchor constraintEqualToAnchor:logoImageView.bottomAnchor constant:20.0],
        [titleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
        [titleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0],
    ]];
}

- (void)buttonTapped:(UIButton *)sender {
    // Manejar la acción al presionar los botones (implementar según sea necesario)
    
    // Crear e iniciar la instancia del segundo controlador de vista (ViewController2)
    DetalleViewController *detalle = [[DetalleViewController alloc] initWithNibName:@"DetalleViewController" bundle:nil];
    detalle.categoria = sender.titleLabel.text;
    // Presentar el segundo controlador de vista
    [self presentViewController:detalle animated:YES completion:nil];
        NSLog(@"Categoría seleccionada: %@",sender.titleLabel.text);
}

- (void)verInfoTapped:(id)sender {
    
}

@end
