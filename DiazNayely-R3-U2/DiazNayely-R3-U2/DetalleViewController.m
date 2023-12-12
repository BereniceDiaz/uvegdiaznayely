//
//  DetalleViewController.m
//  DiazNayely-R3-U2
//
//  Created by Ismael Sánchez Rios on 11/12/23.
//

#import "DetalleViewController.h"

@interface DetalleViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tituloLabel;
@property (weak, nonatomic) IBOutlet UILabel *descripcionLabel;


@end

@implementation DetalleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Crear y configurar el logo
        UIImage *logoImage = [UIImage imageNamed:@"Logoapp"];
        UIImageView *logoImageView = [[UIImageView alloc] initWithImage:logoImage];
        logoImageView.contentMode = UIViewContentModeScaleAspectFit; // Ajusta el modo de contenido según sea necesario
        logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:logoImageView];
        
        // Configurar autolayout para posicionar el logo en la parte superior
        [NSLayoutConstraint activateConstraints:@[
            // Logo centrado en la parte superior
            [logoImageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:40.0],
            [logoImageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
            [logoImageView.widthAnchor constraintEqualToConstant:150.0], // Ajusta el ancho según sea necesario
            [logoImageView.heightAnchor constraintEqualToConstant:150.0], // Ajusta el alto según sea necesario
        ]];
    
    
    NSString *titulo = [NSString stringWithFormat:@" %@", self.categoria];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = titulo;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;

    // Configuración del formato del texto
    titleLabel.font = [UIFont boldSystemFontOfSize:34.0];
    titleLabel.numberOfLines = 1; // Número de líneas (en este caso, una línea)
    titleLabel.adjustsFontSizeToFitWidth = YES; // Ajustar el tamaño del texto si es necesario

    [self.view addSubview:titleLabel];
    
    
    // Botón para cambiar la descripción
        UIButton *changeDescriptionButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [changeDescriptionButton setTitle:@"Cambiar Descripción" forState:UIControlStateNormal];
        [changeDescriptionButton addTarget:self action:@selector(cambiarDescripcionTapped:) forControlEvents:UIControlEventTouchUpInside];
        changeDescriptionButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:changeDescriptionButton];
    [changeDescriptionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changeDescriptionButton.backgroundColor = [UIColor colorWithRed:(216.0/255.0) green:(204.0/255.0) blue:(241.0/255.0) alpha:1.0];
    changeDescriptionButton.layer.cornerRadius = 8.0; // Bordes redondeados
    
        // Botón para regresar
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [backButton setTitle:@"Regresar" forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(regresarTapped:) forControlEvents:UIControlEventTouchUpInside];
        backButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:backButton];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor colorWithRed:(216.0/255.0) green:(204.0/255.0) blue:(241.0/255.0) alpha:1.0];
    backButton.layer.cornerRadius = 8.0; // Bordes redondeados
    
    // Configurar autolayout para posicionar los botones
        [NSLayoutConstraint activateConstraints:@[
            // Posicionamiento verticalmente centrado
            
            [changeDescriptionButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:60.0],
            [backButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:100.0],
            
            // Alineación horizontal
            [changeDescriptionButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
            [backButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        ]];
    
    // Descripción
    NSString *descripcion = [NSString stringWithFormat:@"%@", [self descripcionParaCategoria:self.categoria]];
    
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.text = descripcion;
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    self.descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.descLabel.numberOfLines = 0; // Permite múltiples líneas
    self.descLabel.adjustsFontSizeToFitWidth = YES; // Ajusta el tamaño del texto si es necesario
    self.descLabel.minimumScaleFactor = 0.5; // Escala mínima del texto
    self.descLabel.font = [UIFont systemFontOfSize:18.0]; // Ajusta el tamaño de la fuente de la descripción
    [self.view addSubview:self.descLabel];
    
    // Configurar autolayout para posicionar las etiquetas
    [NSLayoutConstraint activateConstraints:@[
        // Posicionamiento verticalmente centrado
        [titleLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-40.0],
        [self.descLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:20.0],
        
        // Alineación horizontal
        [titleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
        [titleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0],
        [self.descLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
        [self.descLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0],
    ]];
}

// Método para cambiar la descripción al presionar el botón correspondiente
- (void)cambiarDescripcionTapped:(UIButton *)sender {
    NSString *nuevaDescripcion = [self descripcionParaCategoria:self.categoria];
    self.descripcionLabel.text = nuevaDescripcion;
    self.descLabel.text = nuevaDescripcion;
    
}



- (IBAction)regresarTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)descripcionParaCategoria:(NSString *)categoria {
    // Diccionario con tips de verdad correspondientes a cada categoría
    NSDictionary *descripciones = @{
        @"Miscelanea": @[
            @"No te olvides de sonreír cada día, incluso si es difícil.",
            @"La paciencia es una virtud valiosa en todos los aspectos de la vida.",
            @"Escuchar música puede mejorar tu estado de ánimo en situaciones estresantes.",
            @"Mantenerse hidratado es esencial para la salud en general.",
            @"Practicar la gratitud diariamente puede mejorar tu bienestar emocional.",
            @"Aprender algo nuevo cada día puede estimular tu mente y creatividad.",
            @"Tomarse un descanso puede ser tan productivo como trabajar arduamente.",
            @"La lectura regular puede ampliar tus horizontes y conocimientos.",
            @"El ejercicio físico regular es clave para una vida saludable.",
            @"Buscar el equilibrio en la vida puede ayudarte a mantenerte centrado."
        ],
        @"Biología": @[
            @"La diversidad biológica es fundamental para la estabilidad de los ecosistemas.",
            @"El ADN es la molécula que lleva la información genética de los seres vivos.",
            @"Las células son la unidad básica de la vida.",
            @"La fotosíntesis es el proceso mediante el cual las plantas producen su alimento.",
            @"Los ecosistemas están compuestos por comunidades biológicas y factores abióticos.",
            @"Los animales vertebrados tienen columna vertebral, los invertebrados no.",
            @"El agua es vital para la vida en la Tierra y constituye una gran parte de los organismos.",
            @"El ciclo del carbono es esencial para el equilibrio climático.",
            @"La conservación de la biodiversidad es crucial para la supervivencia de muchas especies.",
            @"La evolución biológica es el proceso por el cual las especies cambian con el tiempo."
        ],
        @"Temas de interés": @[
            @"La inteligencia artificial está transformando muchos aspectos de nuestra sociedad.",
            @"La sostenibilidad es clave para el futuro del planeta y las generaciones futuras.",
            @"La globalización ha conectado a las personas y culturas de todo el mundo.",
            @"La ética en la ciencia y la tecnología es fundamental para su uso responsable.",
            @"La igualdad de género es un objetivo importante para lograr una sociedad más justa.",
            @"La innovación tecnológica está cambiando rápidamente la forma en que vivimos.",
            @"La educación es un pilar fundamental para el progreso y desarrollo humano.",
            @"La cultura y las artes son elementos importantes que enriquecen nuestras vidas.",
            @"El emprendimiento puede generar impacto social y económico positivo.",
            @"La salud mental es tan importante como la salud física en nuestra vida diaria."
        ],
        
    };
    
    // Obtener el array de tips de verdad para la categoría seleccionada
    NSArray *tipsParaCategoria = descripciones[categoria];
    
    // Verificar si existe la categoría en el diccionario y devolver un tip de verdad aleatorio
    if (tipsParaCategoria) {
        NSUInteger randomIndex = arc4random_uniform((uint32_t)tipsParaCategoria.count);
        return tipsParaCategoria[randomIndex];
    } else {
        return @"Descripción no disponible.";
    }
}


@end
