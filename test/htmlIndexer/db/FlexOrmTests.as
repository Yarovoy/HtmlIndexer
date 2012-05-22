package htmlIndexer.db
{

	import flash.data.SQLStatement;

	import htmlIndexer.mate.vos.LinkVO;

	import mx.collections.ArrayCollection;

	import nz.co.codec.flexorm.EntityManager;

	import org.flexunit.asserts.assertEquals;

	public class FlexOrmTests
	{

		private var em:EntityManager = EntityManager.instance;

		[Before]
		public function setUp():void
		{
			em.openSyncConnection('test');
		}

		[After]
		public function tearDown():void
		{
			const sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.text = 'DELETE FROM links; DELETE FROM pages;';
			sqlStatement.sqlConnection = em.sqlConnection;
			sqlStatement.execute();

			em.sqlConnection.close();
		}

		[Test]
		public function testLinkCreating():void
		{
			const firstLink:LinkVO = new LinkVO('http://ya.ru', 'Яндекс');
			em.save(firstLink);

			var result:ArrayCollection = em.findAll(LinkVO);
			assertEquals(1, result.length);

			const secondLink:LinkVO = new LinkVO('http://yarovoy.com', "Brains'trim");
			em.save(secondLink);

			result = em.findAll(LinkVO);
			assertEquals(2, result.length);
		}
	}
}