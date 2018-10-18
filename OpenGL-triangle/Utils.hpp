//
//  Utils.hpp
//  OpenGL-triangle
//
//  Created by 叩问九天 on 2018/10/18.
//  Copyright © 2018年 kevin. All rights reserved.
//

#ifndef Utils_hpp
#define Utils_hpp

#include <stdio.h>
#include <OpenGLES/ES2/glext.h>

GLuint CompileShader(GLenum shaderType, const char *code);
GLuint CreateGPUProgram(const char *vsCode, const char *fsCode);
GLuint CreateBufferObject(GLenum objType, int objSize, void *data, GLenum usage);

#endif /* Utils_hpp */
