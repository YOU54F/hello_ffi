export interface Greeter {
    SayHello(request: HelloRequest): Promise<HelloReply>;
    ShoutHello(request: HelloRequest): AsyncGenerator<HelloReply>;
  }
  
  export interface HelloRequest {
    name?: string;
  }
  
  export interface HelloReply {
    message?: string;
  }