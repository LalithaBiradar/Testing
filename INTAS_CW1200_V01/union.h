#ifndef UNION_H
#define UNION_H


typedef union IPDATA {
    unsigned char sInput;
    struct{

        unsigned char ipfrcover:1;
        unsigned char ipdoor:1;
        unsigned char ipairprs:1;
        unsigned char ipestop:1;
        unsigned char ipmdverif:1;
        unsigned char ipcwverif:1;
        unsigned char ipfg1:1;
        unsigned char ipcwrejc:1;

    }SBIT;

}IPDATA;
extern IPDATA i2cipdata;

#endif // UNION_H
