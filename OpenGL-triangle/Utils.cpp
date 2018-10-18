//
//  Utils.cpp
//  OpenGL-triangle
//
//  Created by 叩问九天 on 2018/10/18.
//  Copyright © 2018年 kevin. All rights reserved.
//

#include "Utils.hpp"

GLuint CompileShader(GLenum shaderType, const char *code)
{
    GLuint shader = glCreateShader(shaderType);
    glShaderSource(shader, 1, &code, NULL);
    glCompileShader(shader);
    GLint compileStatus = GL_TRUE;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &compileStatus);
    if (compileStatus == GL_FALSE) {
        printf("compile shader error, shader code is ： %s\n", code);
        char szBuffer[1024] = {0};
        GLsizei length = 0;
        glGetShaderInfoLog(shader, 1024, &length, szBuffer);
        printf("error log : %s \n", szBuffer);
        glDeleteShader(shader);
        return 0;
    }
    return shader;
}

GLuint CreateGPUProgram(const char *vsCode, const char *fsCode)
{
    GLuint program = glCreateProgram();
   
    GLuint vsShader = CompileShader(GL_VERTEX_SHADER, vsCode);
    GLuint fsShader = CompileShader(GL_FRAGMENT_SHADER, fsCode);
    glAttachShader(program, vsShader);
    glAttachShader(program, fsShader);
    glLinkProgram(program);
    GLint programStatus = GL_TRUE;
    glGetProgramiv(program, GL_LINK_STATUS, &programStatus);
    if (programStatus == GL_FALSE) {
        printf("link program error");
        char szBuffer[1024] = {0};
        GLsizei length = 0;
        glGetProgramInfoLog(program, 1024, &length, szBuffer);
        printf("link error : %s \n", szBuffer);
        glDeleteProgram(program);
        return 0;
    }
    return program;
}


GLuint CreateBufferObject(GLenum objType, int objSize, void *data, GLenum usage)
{
    GLuint bufferObj;
    glGenBuffers(1, &bufferObj);
    glBindBuffer(objType, bufferObj);
    glBufferData(objType, objSize, data, usage);
    glBindBuffer(objType, 0);
    return bufferObj;
}

