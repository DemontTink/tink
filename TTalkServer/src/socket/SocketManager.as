package socket
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.utils.ByteArray;

	public class SocketManager
	{
		private static var _instance:SocketManager;
		
		private var _serverSocket:ServerSocket;
		private var _crossDomainSocket:ServerSocket;
		private var _clientSockets:Vector.<Socket> = new Vector.<Socket>();
		
		public function SocketManager()
		{
			
		}
		
		public static function get instance():SocketManager
		{
			if(!_instance)
			{
				_instance = new SocketManager();
			}
			return _instance;
		}
		
		/**
		 *设置服务器 
		 */		
		public function setupServer():void
		{
			try
			{
				_crossDomainSocket = new ServerSocket();
				_crossDomainSocket.bind(843, "127.0.0.1");
				_crossDomainSocket.addEventListener(ServerSocketConnectEvent.CONNECT, __crossSocketConnectComplete);
				_crossDomainSocket.listen();
			} 
			catch(error:Error) 
			{
				trace("crossDomain connect error!");
			}
			
			try
			{	
				_serverSocket = new ServerSocket();
				_serverSocket.bind(6666, "127.0.0.1");
				_serverSocket.addEventListener(ServerSocketConnectEvent.CONNECT, __socketConnectComplete);
				_serverSocket.listen();
			} 
			catch(error:Error) 
			{
				trace("serverSocket connect error!");
			}
		}
		
		private function __crossSocketConnectComplete(event:ServerSocketConnectEvent):void
		{
			// TODO Auto-generated method stub
			trace("crossDomain connect complete!");
			var clientSocket:Socket = event.socket;
			clientSocket.addEventListener(ProgressEvent.SOCKET_DATA,__onCrossDomainData);
		}
		
		private function __onCrossDomainData(evt:ProgressEvent):void
		{
			_crossDomainSocket.removeEventListener(ProgressEvent.SOCKET_DATA,__onCrossDomainData);
			var crossDomainClient:Socket = evt.target as Socket;
			crossDomainClient.writeUTFBytes(
				'<cross-domain-policy>' + 
				'		<allow-access-from domain="*" to-ports="*" />' + 
				'</cross-domain-policy>' + String.fromCharCode(0));
			crossDomainClient.flush();
		}
		
		/**
		 *客户端连接成功 
		 * @param event
		 * 
		 */		
		private function __socketConnectComplete(event:ServerSocketConnectEvent):void
		{
			// TODO Auto-generated method stub
			trace("serverSocket connect complete!");
			var clientSocket:Socket = event.socket;
			_clientSockets.push(clientSocket);
			trace("客户端连接:" + clientSocket.remoteAddress + ",端口:" + clientSocket.remotePort);
			clientSocket.addEventListener(ProgressEvent.SOCKET_DATA, __recieveClientSocketData);
			clientSocket.addEventListener(Event.CLOSE, __clientClose);
			
			
			var byteArr:ByteArray = new ByteArray();
			byteArr.writeUTF("server reback:client conneted completed!");
			clientSocket.writeBytes(byteArr);
			clientSocket.flush();
		}
		
		/**
		 *接收客户端协议 
		 * @param event
		 * 
		 */		
		private function __recieveClientSocketData(event:ProgressEvent):void
		{
			// TODO Auto-generated method stub
			var clientSocket:Socket = event.target as Socket;
			var data:ByteArray = new ByteArray();
			clientSocket.readBytes(data, data.length, clientSocket.bytesAvailable);
			trace(data);
		}
		
		/**
		 *客户端关闭 
		 * @param event
		 * 
		 */		
		private function __clientClose(event:Event):void
		{
			// TODO Auto-generated method stub
			var clientSocket:Socket = event.target as Socket;
			clientSocket.removeEventListener(ProgressEvent.SOCKET_DATA,__onCrossDomainData);
			clientSocket.removeEventListener(Event.CLOSE, __clientClose);
			
			var index:int = _clientSockets.indexOf(clientSocket);
			if(index > -1)
			{
				_clientSockets.splice(index, 1);
			}
		}
	}
}