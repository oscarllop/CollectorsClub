using System;
using System.IO;
using System.Text;
using System.Web;

namespace CollectorsClub.Modules {

	public delegate string FilterReplacementDelegate(string s);

	public class InsertionFilterStream : Stream {

		private Stream _originalStream;
		private Encoding _encoding;
		private FilterReplacementDelegate _replacementFunction;
		private long _length;
		private long _position;
		string sBuffer = string.Empty;
		bool _seHaProcesadoLaSalida = false;

		public InsertionFilterStream(Stream originalStream, FilterReplacementDelegate replacementFunction, Encoding encoding) {
			_originalStream = originalStream;
			_replacementFunction = replacementFunction;
			_encoding = encoding;
		}

		public override bool CanRead { get { return false; } }
		public override bool CanSeek { get { return true; } }
		public override bool CanWrite { get { return true; } }
		public override long Length { get { return _length; } }
		public override long Position { get { return _position; } set { _position = value; } }

		public override int Read(Byte[] buffer, int offset, int count) {
			throw new NotSupportedException();
		}

		public override long Seek(long offset, SeekOrigin direction) {
			return _originalStream.Seek(offset, direction);
		}

		public override void SetLength(long length) {
			_length = length;
		}

		public override void Flush() {
			if (!_seHaProcesadoLaSalida) {
				string sReplacement = _replacementFunction(sBuffer);
				_originalStream.Write(_encoding.GetBytes(sReplacement), 0, _encoding.GetByteCount(sReplacement));
				_originalStream.Flush();
				_seHaProcesadoLaSalida = true;
			}
		}

		public override void Write(byte[] buffer, int offset, int count) {
			sBuffer += _encoding.GetString(buffer, offset, count);
		}
	}
}