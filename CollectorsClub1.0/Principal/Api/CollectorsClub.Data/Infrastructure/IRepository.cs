using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Linq.Expressions;

namespace CollectorsClub.Data.Infrastructure {

	public interface IRepository<T> where T : class {
		void Add(T entity);
		void Update(T entity);
		void Delete(T entity);
		void Delete(Expression<Func<T, bool>> where);
		T GetById(object id);
		//T GetById(long id);
		//T GetById(string id);
		T GetById(params object[] key);
		T GetById(string[] includes, Expression<Func<T, bool>> _predicate);
		T Get(Expression<Func<T, bool>> where);
		IEnumerable<T> GetAll();
		IEnumerable<T> GetAll(string[] includes);
		IEnumerable<T> GetMany(Expression<Func<T, bool>> where);
		IEnumerable<T> GetMany(string[] includes, Expression<Func<T, bool>> where);
		IEnumerable<T> GetQuery(string query, params object[] parameters);
		int Count();
		int Count(Expression<Func<T, bool>> where);
		bool Exist(Expression<Func<T, bool>> where);
	}
}
