// T4OPCServer.h

#define T4OPCAPI 
#ifdef __cplusplus
extern "C" {
#endif
// CallbackHandlers for int, double and array tags can be registered while adding the tags.
// If registered, the callback function will be called if a client writes a new value to that tag.
// Do not use these handlers if the client is not allowed to write to the server.
typedef void (*T4OPC_CallbackHandlerInt)(int);
typedef void (*T4OPC_CallbackHandlerDouble)(double);
typedef void (*T4OPC_CallbackHandlerArray)(int *);
// Starts a server on local machine on port 4840
// accessible as opc.tcp://<IP Address>:4840 from local network
// "Manufacturer" tag with value "TEPL" is already added by default
// returns 1 for success. 0 for failure.
T4OPCAPI int T4OPC_BeginServer(void);
// Stops the server
T4OPCAPI void T4OPC_EndServer(void);
// If you need integer arrays, up to four arrayTypes can be set up. Each type with a different length.
// e.g. To set up three arrayTypes with lengths 128, 256 and 1400
// have a lengths array 
// int lengths[] = {128, 256, 1400};
// and call T4OPC_SetupServerArrays(3, lengths);
// NOTE these are array TYPES. Any number of tags for each type can be added to the server.
// In this example, arrayType 1 is an integer array of length 128. arrayType 3 a length of 1400.
// IMPORTANT: arrayType does NOT begin with 0. It goes from 1 to 4.
T4OPCAPI int T4OPC_SetupServerArrays( int numberOfArrays, int *lengths);
// Tags must be added to the server so that clients can access data.
// Each tag must have a unique tagname. CallbackHandler can be specified if clients are allowed to 
// write to the server. Otherwise use NULL for handler pointers.
T4OPCAPI int T4OPC_AddTagInt(char *tagname, int value, T4OPC_CallbackHandlerInt);
T4OPCAPI int T4OPC_AddTagDouble(char *tagname, double value, T4OPC_CallbackHandlerDouble);
T4OPCAPI int T4OPC_AddTagString(char *tagname, char *str);
// IMPORTANT: arrayType must be between 1 to 4, depending upon your number of arrayTypes set up.
// length of the input data array MUST exactly equal the corresponding arrayType.
T4OPCAPI int T4OPC_AddTagArray(char *tagname, int *data, int arrayType, T4OPC_CallbackHandlerArray);
// Once tags are added to the server, values can be changed by WriteTag functions.
T4OPCAPI int T4OPC_WriteTagInt(char *tagname, int newvalue);
T4OPCAPI int T4OPC_WriteTagDouble(char *tagname, double newvalue);
T4OPCAPI int T4OPC_WriteTagString(char *tagname, char *newstr);
T4OPCAPI int T4OPC_WriteTagArray(char *tagname, int *newdata, int arrayType);

#define T4OPC_MAX_ARRAYTYPES 4

#ifdef __cplusplus
}
#endif
