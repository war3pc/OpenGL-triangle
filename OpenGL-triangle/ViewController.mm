//
//  ViewController.m
//  OpenGL-triangle
//
//  Created by 叩问九天 on 2018/10/18.
//  Copyright © 2018年 kevin. All rights reserved.
//

#import "ViewController.h"
#import <OpenGLES/ES2/glext.h>
#include "Utils.hpp"

GLuint posLocation, colorLocation;
GLuint gpuProgram;
GLuint vbo;
float color[] = {1.0, 0, 0, 1.0};

@interface ViewController ()

@property (nonatomic, strong) EAGLContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView *v = (GLKView *)self.view;
    v.context = self.context;
    v.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
    [self setupScene];
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
}

- (char *)loadCode:(NSString *)filename
{
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    char *assetContent = new char[data.length+1];
    memcpy(assetContent, data.bytes, data.length);
    assetContent[data.length] = '\0';
    
    return assetContent;
}

- (void)setupScene
{
    float data[] = {
      -0.5, 0, 0,
        0.5, 0, 0,
        0, 0.5, 0
    };
    vbo = CreateBufferObject(GL_ARRAY_BUFFER, sizeof(float)*9, data, GL_STATIC_DRAW);
    char *vsCode = [self loadCode:@"Shader.vsh"];
    char *fsCode = [self loadCode:@"Shader.fsh"];
    gpuProgram = CreateGPUProgram(vsCode, fsCode);
    posLocation = glGetAttribLocation(gpuProgram, "pos");
    colorLocation = glGetUniformLocation(gpuProgram, "U_Color");
    delete vsCode;
    delete fsCode;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view != nil && [self isViewLoaded]) {
        self.view = nil;
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }
}



- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.5, 1.0, 0.5, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
//    NSLog(@"render")
    glUseProgram(gpuProgram);
    glUniform4fv(colorLocation, 1, color);
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    
    glEnableVertexAttribArray(posLocation);
    glVertexAttribPointer(posLocation, 3, GL_FLOAT, GL_FALSE, sizeof(float)*3, 0);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glUseProgram(0);
    
}

- (void)update
{
//    NSLog(@"update");
}

@end
