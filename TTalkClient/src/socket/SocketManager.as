package socket
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;

	public class SocketManager
	{
		private static var _instance:SocketManager;
		
		private var _socket:Socket;
		
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
		 *设置客户端 
		 * @param host
		 * @param port
		 * 
		 */		
		public function setupClient(host:String,port:int):void
		{
			_socket = new Socket();
			_socket.addEventListener(Event.CONNECT, __socketConnectComplete);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, __socketConnectError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,__socketConnectError);
			_socket.addEventListener(Event.CLOSE,__socketClosed);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA,__receiveServerData);
			_socket.connect(host,port);
		}
		
		/**
		 *接收服务器协议 
		 * @param event
		 * 
		 */		
		private function __receiveServerData(event:ProgressEvent):void
		{
			// TODO Auto-generated method stub
			var sc:Socket = event.target as Socket;
			var byteArr:ByteArray = new ByteArray();
			sc.readBytes(byteArr);
			
			trace(byteArr.readUTF());
		}
		
		/**
		 *连接服务器成功 
		 * @param event
		 * 
		 */		
		private function __socketConnectComplete(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("connect server complete!");
		}
		/**
		 *连接服务器失败 
		 * @param event
		 * 
		 */		
		private function __socketConnectError(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			trace("connect server error!");
		}
		/**
		 *服务器关闭 
		 * @param event
		 * 
		 */		
		private function __socketClosed(event:Event):void
		{
			trace("server closed!");
		}
	}
}